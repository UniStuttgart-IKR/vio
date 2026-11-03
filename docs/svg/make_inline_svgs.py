"""Inline SVG figures of risc-vio.md (memory views, pointer arithmetic, register file, object overview,
colour transitions, instruction streams, heap), drawn like the output of make_diagrams.py.
Run it to print the ```{=html} blocks, then paste them into the Markdown.

Every SVG carries the same style block as the generated diagrams (tile colours, dark mode),
extended by arrows, dots and brackets. The viewer nests each <style> under its own SVG.
"""
from html import escape

ROW = 26

STYLE = """<style>
  text { font-family: "Roboto Mono", ui-monospace, "SF Mono", Menlo, Consolas, "DejaVu Sans Mono", "Liberation Mono", monospace; font-size: 13px; font-weight: 700; fill: #1a1a1a;
          text-anchor: middle; dominant-baseline: central; }
  text.label { font-size: 10px; font-weight: 400; fill: #5a5a5a; }
  text.heading { font-size: 12px; }
  text.start { text-anchor: start; }
  text.end { text-anchor: end; }
  text.small { font-size: 10px; font-weight: 400; font-style: italic; }
  .outline { fill: none; stroke: #000; stroke-width: 2; shape-rendering: crispEdges; }
  .divider { fill: none; stroke: #000; stroke-width: 1; shape-rendering: crispEdges; }
  .diagonal { stroke: #000; stroke-width: 1; }
  .rule { stroke: #000; stroke-width: 2; shape-rendering: crispEdges; }
  .dashed { stroke-dasharray: 4 3; }
  .arrow { fill: none; stroke: #1a1a1a; stroke-width: 1.5; }
  .head, .dot { fill: #1a1a1a; }
  .bracket { fill: none; stroke: #ff55dd; stroke-width: 2; }
  text.code { font-size: 12px; font-weight: 400; text-anchor: start; }
  .c-white { fill: #ffffff; stroke: #000; stroke-width: 2; }
  .c-black { fill: #1a1a1a; stroke: #000; stroke-width: 2; }
  .red { fill: #ff7a7a }
  .edge { fill: none; stroke: #000; stroke-width: 1; shape-rendering: crispEdges; }
  .grey { fill: #d0d0d0 }
  .dark-grey { fill: #a0a0a0 }
  .purple { fill: #ccaaff }
  .blue { fill: #80e5ff }
  .green { fill: #55ff99 }
  .cyan { fill: #55ffdd }
  .light-pink { fill: #ffaaee }
  .pink { fill: #ff55dd }
  .yellow { fill: #e5ff80 }
  .white { fill: #ffffff }
  @media (prefers-color-scheme: dark) {
    text { fill: #cccccc; }
    text.label { fill: #9a9a9a; }
    /* lines become gaps in the page colour between the tinted tiles */
    .outline, .divider, .diagonal { stroke: #1a1a1a; }
    .rule, .dashed { stroke: #cccccc; }
    .arrow { stroke: #cccccc; }
    .head, .dot { fill: #cccccc; }
    .c-white { fill: #cccccc; stroke: #cccccc; }
    .c-black { fill: #000000; stroke: #cccccc; }
    .red { fill: #ff7a7a40 }
    .edge { stroke: #9a9a9a; }
    text.on-red { fill: #ff7a7a }
    .grey { fill: #ffffff26 }
    .dark-grey { fill: #ffffff4d }
    .white { fill: #ffffff1a }
    .purple { fill: #ccaaff40 }
    text.on-purple { fill: #ccaaff }
    .blue { fill: #80e5ff40 }
    text.on-blue { fill: #80e5ff }
    .green { fill: #55ff9940 }
    text.on-green { fill: #55ff99 }
    .cyan { fill: #55ffdd40 }
    text.on-cyan { fill: #55ffdd }
    .light-pink { fill: #ffaaee40 }
    text.on-light-pink { fill: #ffaaee }
    .pink { fill: #ff55dd40 }
    text.on-pink { fill: #ff55dd }
    .yellow { fill: #e5ff8040 }
    text.on-yellow { fill: #e5ff80 }
  }
  </style>"""


class Svg:
    def __init__(self, width, height, title):
        self.width, self.height, self.title = width, height, title
        self.items = []

    def add(self, item):
        self.items.append(item)

    def text(self, x, y, text, cls=''):
        c = f' class="{cls}"' if cls else ''
        self.add(f'<text x="{x:g}" y="{y:g}"{c}>{escape(text)}</text>')

    def rect(self, x, y, w, h, cls):
        self.add(f'<rect x="{x:g}" y="{y:g}" width="{w:g}" height="{h:g}" class="{cls}"/>')

    def line(self, x1, y1, x2, y2, cls):
        self.add(f'<line x1="{x1:g}" y1="{y1:g}" x2="{x2:g}" y2="{y2:g}" class="{cls}"/>')

    def tile(self, x, y, w, h, colour, text=None, outline=True, dashed=False):
        """A filled tile with centred text, as in the generated diagrams."""
        self.rect(x, y, w, h, colour)
        if text is not None:
            self.text(x + w / 2, y + h / 2, text, f'on-{colour}')
        if outline:
            self.rect(x, y, w, h, 'outline dashed' if dashed else 'outline')

    def arrow(self, points, head='right', dot=True, label=None, label_at=None, cls='arrow'):
        """A polyline arrow from points[0] to points[-1] with a dot at its start."""
        path = ' '.join(f'{x:g},{y:g}' for x, y in points)
        x, y = points[-1]
        self.add(f'<polyline points="{path}" class="{cls}"/>')
        heads = {'right': (-7, 0), 'left': (7, 0), 'down': (0, -7)}
        dx, dy = heads[head]
        if dy:
            tri = f'{x:g},{y:g} {x - 4:g},{y + dy:g} {x + 4:g},{y + dy:g}'
        else:
            tri = f'{x:g},{y:g} {x + dx:g},{y - 4:g} {x + dx:g},{y + 4:g}'
        self.add(f'<polygon points="{tri}" class="head"/>')
        if dot:
            sx, sy = points[0]
            self.add(f'<circle cx="{sx:g}" cy="{sy:g}" r="3" class="dot"/>')
        if label:
            lx, ly = label_at
            self.text(lx, ly, label, 'heading')

    def curve(self, p0, c, p1, label=None, label_at=None):
        """A quadratic curve from p0 to p1 with an arrowhead along its end tangent."""
        import math
        (x0, y0), (cx, cy), (x1, y1) = p0, c, p1
        self.add(f'<path d="M{x0:g},{y0:g} Q{cx:g},{cy:g} {x1:g},{y1:g}" class="arrow"/>')
        a = math.atan2(y1 - cy, x1 - cx)
        pts = [(x1, y1)]
        for side in (1, -1):
            pts.append((x1 - 8 * math.cos(a) + side * 4 * math.sin(a), y1 - 8 * math.sin(a) - side * 4 * math.cos(a)))
        self.add('<polygon points="' + ' '.join(f'{x:.1f},{y:.1f}' for x, y in pts) + '" class="head"/>')
        if label:
            self.text(*label_at, label, 'heading')

    def circle(self, cx, cy, r, cls):
        self.add(f'<circle cx="{cx:g}" cy="{cy:g}" r="{r:g}" class="{cls}"/>')

    def render(self):
        body = '\n  '.join(self.items)
        return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{self.width}" height="{self.height}" '
                f'viewBox="-2 -2 {self.width} {self.height}" role="img">\n'
                f'  <title>{escape(self.title)}</title>\n  {STYLE}\n  {body}\n</svg>')


# ============================================================================ pointer arithmetic

def operand(svg, y, value):
    """value: ('prim', v) | ('ptr', base, index) | ('exception',)"""
    if value[0] == 'prim':
        svg.tile(80, y, 72, ROW, 'blue', value[1])
    elif value[0] == 'ptr':
        svg.tile(22, y, 52, ROW, 'pink', value[1])
        svg.tile(80, y, 72, ROW, 'blue', value[2])
    else:
        svg.tile(22, y, 130, ROW, 'white', 'exception', dashed=True)


def arithmetic(title, first, op, second, result):
    svg = Svg(156, 112, title)
    operand(svg, 0, first)
    operand(svg, 38, second)
    svg.text(9, 51, op, 'heading')
    svg.line(0, 72, 152, 72, 'rule')
    operand(svg, 82, result)
    return svg.render()


def composition():
    svg = Svg(388, 44, 'Composition of a pointer')
    for x, text, cls in ((382, '0', 'label end'), (194, '31', 'label start'), (190, '32', 'label end'), (2, '63', 'label start')):
        svg.text(x, 5, text, cls)
    svg.rect(0, 14, 192, ROW, 'pink')
    svg.text(96, 27, 'base', 'on-pink')
    svg.rect(192, 14, 192, ROW, 'blue')
    svg.text(288, 27, 'index', 'on-blue')
    svg.line(192, 14, 192, 40, 'divider')
    svg.rect(0, 14, 384, ROW, 'outline')
    return svg.render()


ARITHMETIC = [
    ('a) primitive + primitive', arithmetic('Primitive plus primitive', ('prim', '12'), '+', ('prim', '34'), ('prim', '46'))),
    ('b) pointer + primitive', arithmetic('Pointer plus primitive', ('prim', '46'), '+', ('ptr', 'A', '12'), ('ptr', 'A', '58'))),
    ('c) pointer − pointer, same object', arithmetic('Pointer minus pointer to the same object', ('ptr', 'A', '58'), '−', ('ptr', 'A', '12'), ('prim', '46'))),
    ('d) pointer − pointer, different objects', arithmetic('Pointer minus pointer to another object', ('ptr', 'A', '58'), '−', ('ptr', 'B', '12'), ('exception',))),
    ('e) pointer + pointer', arithmetic('Pointer plus pointer', ('ptr', 'A', '12'), '+', ('ptr', 'A', '46'), ('exception',))),
]


# ============================================================================ memory views

X0, X1 = 90, 190          # memory column
TOP = 30                  # first row
LANE = 208                # lane of the arrows on the right
TAGS = 228                # tag column
VIEW_H = 296              # common height, so that the sub-captions line up


def column(svg, rows, top=TOP, dashed=False, outline=True):
    """rows: [(text, colour, height_in_rows)] drawn as one column; returns the y of every row."""
    ys, y = [], top
    for text, colour, n in rows:
        svg.rect(X0, y, X1 - X0, n * ROW, colour)
        if text:
            svg.text((X0 + X1) / 2, y + n * ROW / 2, text, f'on-{colour}')
        ys.append(y)
        y += n * ROW
    for yy in ys[1:]:
        svg.line(X0, yy, X1, yy, 'divider dashed' if dashed else 'divider')
    if outline:
        svg.rect(X0, top, X1 - X0, y - top, 'outline dashed' if dashed else 'outline')
    return ys, y


def rails(svg, top, bottom):
    for x in (X0, X1):
        svg.line(x, top - 16, x, top, 'rule')
        svg.line(x, bottom, x, bottom + 16, 'rule')


def register(svg, y, parts):
    """parts: [(text, colour, width)] drawn left of the memory column, centred on row y."""
    x = 4
    for text, colour, w in parts:
        svg.tile(x, y, w, ROW, colour, text)
        x += w
    return x


def view_conventional():
    svg = Svg(252, VIEW_H, 'Conventional memory')
    rows = [(t, 'white', 1) for t in ('"A"', '"B"', '0x50', '"D"', '"E"', '41', '"F"')]
    ys, bottom = column(svg, rows, dashed=True)
    rails(svg, TOP, bottom)
    c = lambda i: ys[i] + ROW / 2
    end = register(svg, ys[0], [('0x40', 'white', 60)])
    svg.arrow([(end, c(0)), (X0, c(0))], label='?', label_at=(77, c(0) - 10))
    svg.arrow([(X1 - 8, c(2)), (LANE, c(2)), (LANE, c(4)), (X1, c(4))], head='left', label='?', label_at=(LANE + 10, (c(2) + c(4)) / 2))
    svg.arrow([(X1 - 8, c(5)), (X1 + 34, c(5))], label='?', label_at=(X1 + 22, c(5) - 10))
    return svg.render()


def view_cheri():
    svg = Svg(252, VIEW_H, 'CHERI memory')
    rows = [('"A"', 'white', 1), ('"B"', 'white', 1), ('cap', 'pink', 2), ('"D"', 'white', 1),
            ('"E"', 'white', 1), ('41', 'white', 1), ('"F"', 'white', 1)]
    ys, bottom = column(svg, rows, dashed=True)
    rails(svg, TOP, bottom)
    c = lambda i: ys[i] + ROW / 2
    # tag bits, kept outside the addressable memory, one per capability-sized granule
    svg.text(TAGS + 8, TOP - 10, 'tag', 'label')
    for g, bit in enumerate('0100'):
        y = TOP + 2 * g * ROW
        svg.tile(TAGS, y, 16, 2 * ROW, 'pink' if bit == '1' else 'white', bit)
    # bounds travel with every capability
    obj1_bottom, obj2_top = ys[4], ys[4]
    svg.add(f'<polyline points="{X0 - 4},{TOP + 3} {X0 - 9},{TOP + 3} {X0 - 9},{obj1_bottom - 3} {X0 - 4},{obj1_bottom - 3}" class="bracket"/>')
    svg.add(f'<polyline points="{X1 + 4},{obj2_top + 3} {X1 + 9},{obj2_top + 3} {X1 + 9},{bottom - 3} {X1 + 4},{bottom - 3}" class="bracket"/>')
    end = register(svg, ys[0], [('cap', 'pink', 56)])
    svg.arrow([(end, c(0)), (X0 - 11, c(0))])
    cap_y = ys[2] + ROW
    svg.arrow([(X1 - 8, cap_y), (LANE, cap_y), (LANE, c(4)), (X1 + 10, c(4))], head='left')
    return svg.render()


def view_mte():
    svg = Svg(252, VIEW_H, 'Memory tagging')
    rows = [('"A"', 'white', 1), ('"B"', 'white', 1), ('0x50', 'white', 1), ('"D"', 'white', 1),
            ('"E"', 'white', 1), ('41', 'white', 1), ('"F"', 'white', 1)]
    ys, bottom = column(svg, rows, dashed=True)
    rails(svg, TOP, bottom)
    c = lambda i: ys[i] + ROW / 2
    # the pointer stored in memory carries its tag in its upper bits
    svg.rect(X0, ys[2], 26, ROW, 'purple')
    svg.text(X0 + 13, c(2), '9', 'on-purple')
    svg.line(X0 + 26, ys[2], X0 + 26, ys[2] + ROW, 'divider')
    # allocation tags of the granules, kept beside the memory
    svg.text(TAGS + 8, TOP - 10, 'tag', 'label')
    svg.tile(TAGS, ys[0], 16, 4 * ROW, 'yellow', '3')
    svg.tile(TAGS, ys[4], 16, 3 * ROW, 'purple', '9')
    end = register(svg, ys[0], [('3', 'yellow', 22), ('0x40', 'white', 48)])
    svg.arrow([(end, c(0)), (X0, c(0))])
    svg.arrow([(X1 - 8, c(2)), (LANE, c(2)), (LANE, c(4)), (X1, c(4))], head='left', label='?', label_at=(LANE - 9, (c(2) + c(4)) / 2))
    svg.arrow([(X1 - 8, c(5)), (LANE + 12, c(5))], label='?', label_at=(LANE, c(5) - 10))
    return svg.render()


def view_vio():
    svg = Svg(252, VIEW_H, 'RISC-ViO memory')
    obj1 = [('header A', 'green', 1), ('"A"', 'blue', 1), ('"B"', 'blue', 1), ('B.0', 'pink', 1), ('"D"', 'blue', 1)]
    obj2 = [('header B', 'green', 1), ('"E"', 'blue', 1), ('41', 'blue', 1), ('"F"', 'blue', 1)]
    ys1, bottom1 = column(svg, obj1)
    ys2, bottom2 = column(svg, obj2, top=bottom1 + 10)
    rails(svg, TOP, bottom2)
    c = lambda y: y + ROW / 2
    # the pointer A.4 sits beside the element it indexes, but references the head of A
    end = register(svg, ys1[2], [('A', 'pink', 26), ('4', 'blue', 26)])
    svg.arrow([(17, ys1[2]), (17, c(ys1[0])), (X0, c(ys1[0]))])
    svg.arrow([(end, c(ys1[2])), (X0, c(ys1[2]))], cls='arrow dashed')
    svg.arrow([(X1 - 8, c(ys1[3])), (LANE, c(ys1[3])), (LANE, c(ys2[0])), (X1, c(ys2[0]))], head='left')
    return svg.render()


MEMORY_VIEWS = [
    ('a) Conventional', view_conventional()),
    ('b) CHERI', view_cheri()),
    ('c) Memory tagging (MTE)', view_mte()),
    ('d) RISC-ViO', view_vio()),
]


# ============================================================================ register file

def register_file():
    svg = Svg(500, 156, 'An example implementation of a RISC-ViO register file')
    heading_y = 8
    svg.text(69, heading_y, 'Pointer?', 'heading')
    svg.text(178, heading_y, 'Base', 'heading')
    svg.text(358, heading_y, 'Index / Value', 'heading')
    cx = 464
    svg.text(cx + 11, heading_y, 'c', 'heading')
    rows = [
        ('zero', '0', ('0', 'white'), ('0', 'blue'), None),
        ('ra', '1', ('ra.base', 'pink'), ('ra.index', 'pink'), None),
        ('sp', '1', ('sp.base', 'pink'), ('sp.index', 'pink'), 'x'),
        ('x3-x31', 'x', ('x', 'white'), ('x', 'white'), None),
    ]
    for r, (name, tag, base, index, colour) in enumerate(rows):
        y = 22 + 34 * r
        svg.text(50, y + 13, name, 'heading end')
        svg.tile(58, y, 22, ROW, 'white', tag)
        svg.rect(88, y, 180, ROW, base[1])
        svg.text(178, y + 13, base[0], f'on-{base[1]}')
        svg.rect(268, y, 180, ROW, index[1])
        svg.text(358, y + 13, index[0], f'on-{index[1]}')
        svg.line(268, y, 268, y + ROW, 'divider')
        svg.rect(88, y, 360, ROW, 'outline')
        if colour:
            svg.tile(cx, y, 22, ROW, 'white', colour)
    return svg.render()


# ============================================================================ Markdown blocks

def figure_row(items):
    """Several SVGs side by side with a)/b) sub-captions, as the viewer lays out images."""
    parts = ['<div class="fig-row">']
    for caption, svg in items:
        parts.append(f'<div class="fig-item">\n{svg}\n<span class="subcaption">{escape(caption)}</span>\n</div>')
    parts.append('</div>')
    return '```{=html}\n' + '\n'.join(parts) + '\n```'


def single(svg):
    return '```{=html}\n' + svg + '\n```'


# ============================================================================ frame colours (figures 7 and 8)

def colour_transitions():
    svg = Svg(380, 316, 'Colour transitions')
    for oy, register, event in ((0, 'ra', 'call / ret'), (160, 'sp', 'alc / alci sp')):
        svg.text(70, oy + 22, 'white', 'heading')
        svg.text(310, oy + 22, 'black', 'heading')
        svg.circle(70, oy + 74, 32, 'c-white')
        svg.circle(310, oy + 74, 32, 'c-black')
        svg.text(190, oy + 65, register)
        svg.text(190, oy + 83, 'colour')
        svg.curve((97, oy + 57), (190, oy + 2), (283, oy + 57), event, (190, oy + 16))
        svg.curve((283, oy + 91), (190, oy + 146), (97, oy + 91), event, (190, oy + 132))
    return svg.render()


NORMAL_FLOW = [
    ('...', '', 'W', 'W', 'main'), ('li', 'a0, 0x1', 'W', 'W', 'main'), ('call', 'fn_a', 'W', 'W', 'main'),
    ('alci', 'sp, 32', 'B', 'W', 'a'), ('sw', 'ra, 4(sp)', 'B', 'B', 'a'), ('sw', 's0, 8(sp)', 'B', 'B', 'a'),
    ('li', 's0, 0x55', 'B', 'B', 'a'), ('call', 'fn_b', 'B', 'B', 'a'),
    ('alci', 'sp, 32', 'W', 'B', 'b'), ('sw', 'ra, 4(sp)', 'W', 'W', 'b'), ('sw', 's0, 8(sp)', 'W', 'W', 'b'),
    ('li', 's0, 0x22', 'W', 'W', 'b'), ('xor', 'a0, a0, s0', 'W', 'W', 'b'), ('lw', 's0, 8(sp)', 'W', 'W', 'b'),
    ('lw', 'ra, 4(sp)', 'W', 'W', 'b'), ('lw', 'sp, 0(sp)', 'W', 'W', 'b'), ('ret', '', 'W', 'B', 'b'),
    ('and', 'a0, a0, s0', 'B', 'B', 'a'), ('lw', 's0, 8(sp)', 'B', 'B', 'a'), ('lw', 'ra, 4(sp)', 'B', 'B', 'a'),
    ('lw', 'sp, 0(sp)', 'B', 'B', 'a'), ('ret', '', 'B', 'W', 'a'),
    ('mv', 's0, a0', 'W', 'W', 'main'), ('...', '', 'W', 'W', 'main'),
]
# fn_b forgets to allocate its frame and stores into the frame of fn_a
FAULTY_FLOW = NORMAL_FLOW[:8] + [('sw', 'ra, 4(sp)', 'W', 'B', 'b', 'exception'), ('...', '', 'W', 'B', 'b', 'trap')]


def _runs(values):
    runs, start = [], 0
    for i in range(1, len(values) + 1):
        if i == len(values) or values[i] != values[start]:
            runs.append((start, i, values[start]))
            start = i
    return runs


def instruction_stream(title, rows):
    R, TOP0 = 17, 34
    xs = {'ra': 10, 'sp': 38, 'state': 66, 'code': 98, 'fn': 338}
    height = TOP0 + R * len(rows)
    svg = Svg(392, height + 4, title)
    svg.text(31, 8, 'colours', 'heading')
    for name, x, w in (('ra', 10, 14), ('sp', 38, 14), ('state', 66, 22), ('instructions', 98, 230), ('function', 338, 44)):
        svg.text(x + w / 2, 24, name, 'heading')
    y = lambda i: TOP0 + R * i
    # register colours
    for column, index in (('ra', 2), ('sp', 3)):
        x = xs[column]
        for a, b, colour in _runs([r[index] for r in rows]):
            svg.rect(x, y(a), 14, R * (b - a), 'c-white' if colour == 'W' else 'c-black')
    # state: regular (colours equal), irregular, exception
    states = []
    for r in rows:
        if len(r) > 5 and r[5] == 'exception':
            states.append('red')
        elif len(r) > 5 and r[5] == 'trap':
            states.append('white')
        else:
            states.append('blue' if r[2] == r[3] else 'yellow')
    for a, b, colour in _runs(states):
        svg.rect(xs['state'], y(a), 22, R * (b - a), colour)
        if a:
            svg.line(xs['state'], y(a), xs['state'] + 22, y(a), 'divider')
    svg.rect(xs['state'], TOP0, 22, R * len(rows), 'outline')
    # instructions
    svg.rect(xs['code'], TOP0, 230, R * len(rows), 'white')
    for i, r in enumerate(rows):
        if states[i] == 'red':
            svg.rect(xs['code'], y(i), 230, R, 'red')
            svg.text(xs['code'] + 224, y(i) + R / 2, 'StateException', 'label end')
        svg.text(xs['code'] + 8, y(i) + R / 2, r[0], 'code')
        svg.text(xs['code'] + 52, y(i) + R / 2, r[1], 'code')
    svg.rect(xs['code'], TOP0, 230, R * len(rows), 'outline')
    # function being executed
    for a, b, fn in _runs([r[4] for r in rows]):
        cls = {'main': 'white', 'a': 'grey', 'b': 'dark-grey'}[fn]
        svg.rect(xs['fn'] + 8, y(a), 28, R * (b - a), cls)
        if fn != 'main':
            svg.text(xs['fn'] + 22, y(a) + R * (b - a) / 2, fn, 'heading')
        if a:
            svg.line(xs['fn'] + 8, y(a), xs['fn'] + 36, y(a), 'divider')
    svg.rect(xs['fn'] + 8, TOP0, 28, R * len(rows), 'outline')
    return svg.render()


STATE_TRANSITIONS = [
    ('a) Transitions during normal program flow', instruction_stream('Colours and states during normal program flow', NORMAL_FLOW)),
    ('b) Transitions during abnormal program flow with exception', instruction_stream('Colours and states when fn_b accesses the frame of fn_a', FAULTY_FLOW)),
]


# ============================================================================ heap (figure 19)

def heap(overflow):
    svg = Svg(352, 344, 'Heap overflow' if overflow else 'Regular heap growth')
    X, W = 110, 130
    top, bottom, start, end = 24, 316, 100, 296
    svg.text(X - 8, top, '0x00000000', 'label end')
    svg.text(X - 8, bottom, '0xFFFFFFFF', 'label end')
    svg.rect(X, start, W, end - start, 'white')
    for yy in (top, bottom):
        svg.line(X, yy, X + W, yy, 'edge dashed')
    svg.line(X, top, X, bottom, 'edge')
    svg.line(X + W, top, X + W, bottom, 'edge')
    # objects, allocated from the heap end towards the heap start
    for y0 in (226, 156):
        svg.tile(X, y0, W, 18, 'green', 'header')
        svg.tile(X, y0 + 18, W, 52, 'blue', 'body')
    svg.rect(X, start, W, end - start, 'outline')
    svg.text(X - 8, start, 'heap start', 'heading end')
    svg.text(X - 8, end, 'heap end', 'heading end')
    if overflow:
        svg.tile(X + 6, 86, W - 12, 18, 'white', 'header', dashed=True)
        svg.tile(X + 6, 104, W - 12, 52, 'white', 'body', dashed=True)
        svg.text(X + W + 8, 86, 'overflow', 'heading start')
    # malc: newest object and heap limit
    svg.arrow([(X + W + 58, 156), (X + W, 156)], head='left', dot=False)
    svg.text(X + W + 8, 147, 'malc.ptr', 'label start')
    svg.arrow([(X + W + 58, start), (X + W, start)], head='left', dot=False)
    svg.text(X + W + 8, start + 9, 'malc.ix', 'label start')
    # allocation direction
    svg.add('<line x1="332" y1="290" x2="332" y2="126" class="arrow"/>')
    svg.add('<polygon points="332,118 328,126 336,126" class="head"/>')
    svg.add('<text x="320" y="208" class="label" transform="rotate(-90 320 208)">allocation direction</text>')
    return svg.render()


HEAP = [('a) Regular heap growth', heap(False)), ('b) Heap overflow', heap(True))]


def object_overview():
    """Figure 2: the generated diagram object1.svg, unchanged."""
    import re
    source = open('svg/software_objects/object1.svg', encoding='utf-8').read()
    return re.sub(r'\s*<!--.*?-->', '', source).strip()


if __name__ == '__main__':
    print(single(composition()))
    print(figure_row(ARITHMETIC))
    print(figure_row(MEMORY_VIEWS))
    print(single(register_file()))
    print(single(object_overview()))
    print(single(colour_transitions()))
    print(figure_row(STATE_TRANSITIONS))
    print(figure_row(HEAP))
