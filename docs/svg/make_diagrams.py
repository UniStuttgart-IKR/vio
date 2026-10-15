"""
Generates the memory-layout diagrams of the spec (bit fields, objects, pointer
arithmetic, register file) so they all share one look:

  * one scale: diagrams are shown 1:1, cell text is 13px, bit numbers 10px
  * all 32-bit objects share one compact bit grid: bits that carry a number get a
    full column, the bits in between are squeezed, so fields of all objects line up
  * crisp black lines: 2px around objects, 1px inside
  * the colour palette of the original diagrams (and pretty_heap.svg)
  * dark mode: tinted tiles with coloured text, separated by dark gaps

Usage:  python3 make_diagrams.py        (writes the SVGs next to this script)
"""
from dataclasses import dataclass, field
from pathlib import Path
from xml.sax.saxutils import escape

HERE = Path(__file__).parent

# ---------------------------------------------------------------- design tokens

FONT = '"Roboto Mono", ui-monospace, "SF Mono", Menlo, Consolas, "DejaVu Sans Mono", "Liberation Mono", monospace'
CELL_TEXT_PX = 13
LABEL_TEXT_PX = 10
ROW_HEIGHT = 26
WIDE_BIT = 15           # bit column that carries a bit number
NARROW_BIT = 4          # squeezed bit column inside a long field
OUTLINE = 2             # around each object / row group
DIVIDER = 1             # between rows and fields inside an object
LABEL_GAP = 4           # between bit numbers and the box below them
MARGIN = 2              # keeps outlines from being clipped at the edges

# light fill, used at 25 % opacity in dark mode (with the full colour for text)
PALETTE = {
    'purple': '#ccaaff', 'blue': '#80e5ff', 'green': '#55ff99', 'cyan': '#55ffdd',
    'light-pink': '#ffaaee', 'pink': '#ff55dd', 'yellow': '#e5ff80', 'white': '#ffffff',
}


def stylesheet():
    fills = '\n'.join(f'  .{name} {{ fill: {hex_} }}' for name, hex_ in PALETTE.items())
    dark_fills = '\n'.join(
        f'    .{name} {{ fill: {hex_}40 }}\n    text.on-{name} {{ fill: {hex_} }}'
        for name, hex_ in PALETTE.items() if name != 'white')
    return f'''
  text {{ font-family: {FONT}; font-size: {CELL_TEXT_PX}px; font-weight: 700; fill: #1a1a1a;
          text-anchor: middle; dominant-baseline: central; }}
  text.label {{ font-size: {LABEL_TEXT_PX}px; font-weight: 400; fill: #5a5a5a; }}
  text.heading {{ font-size: 12px; }}
  text.start {{ text-anchor: start; }}
  text.end {{ text-anchor: end; }}
  text.small {{ font-size: {LABEL_TEXT_PX}px; font-weight: 400; font-style: italic; }}
  .outline {{ fill: none; stroke: #000; stroke-width: {OUTLINE}; shape-rendering: crispEdges; }}
  .divider {{ fill: none; stroke: #000; stroke-width: {DIVIDER}; shape-rendering: crispEdges; }}
  .diagonal {{ stroke: #000; stroke-width: {DIVIDER}; }}
  .rule {{ stroke: #000; stroke-width: {OUTLINE}; shape-rendering: crispEdges; }}
  .dashed {{ stroke-dasharray: 4 3; }}
{fills}
  @media (prefers-color-scheme: dark) {{
    text {{ fill: #cccccc; }}
    text.label {{ fill: #9a9a9a; }}
    /* lines become gaps in the page colour between the tinted tiles */
    .outline, .divider, .diagonal {{ stroke: #1a1a1a; }}
    .rule, .dashed {{ stroke: #cccccc; }}
    .white {{ fill: #ffffff1a }}
{dark_fills}
  }}
'''


# ---------------------------------------------------------------- drawing surface

class Drawing:
    """Collects SVG elements and the bounding box they cover."""

    def __init__(self):
        self.elements = []
        self.max_x = 0
        self.max_y = 0

    def _grow(self, x, y):
        self.max_x = max(self.max_x, x)
        self.max_y = max(self.max_y, y)

    def rect(self, x, y, width, height, css_class):
        self.elements.append(f'<rect x="{x:g}" y="{y:g}" width="{width:g}" height="{height:g}" class="{css_class}"/>')
        self._grow(x + width, y + height)

    def polygon(self, points, css_class):
        self.elements.append(f'<polygon points="{" ".join(f"{x:g},{y:g}" for x, y in points)}" class="{css_class}"/>')
        for x, y in points:
            self._grow(x, y)

    def line(self, x1, y1, x2, y2, css_class='divider'):
        self.elements.append(f'<line x1="{x1:g}" y1="{y1:g}" x2="{x2:g}" y2="{y2:g}" class="{css_class}"/>')
        self._grow(max(x1, x2), max(y1, y2))

    def text(self, x, y, content, css_class=''):
        if not content:
            return
        class_attr = f' class="{css_class}"' if css_class else ''
        self.elements.append(f'<text x="{x:g}" y="{y:g}"{class_attr}>{escape(content)}</text>')
        # monospace glyphs are about 0.6 em wide; grow the box by the text's extent
        size = LABEL_TEXT_PX if ('label' in css_class or 'small' in css_class) else CELL_TEXT_PX
        width = len(content) * size * 0.6
        if 'start' in css_class:
            right = x + width
        elif 'end' in css_class:
            right = x
        else:
            right = x + width / 2
        self._grow(right, y + size / 2)

    def save(self, relative_path, title):
        # drawn content spans 0…max; the margin on every side keeps outlines unclipped
        width = round(self.max_x + 2 * MARGIN)
        height = round(self.max_y + 2 * MARGIN)
        body = '\n  '.join(self.elements)
        svg = (f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" '
               f'viewBox="{-MARGIN} {-MARGIN} {width} {height}" role="img">\n'
               f'  <!-- generated by make_diagrams.py, edit the script instead of this file -->\n'
               f'  <title>{escape(title)}</title>\n'
               f'  <style>{stylesheet()}  </style>\n  {body}\n</svg>\n')
        (HERE / relative_path).write_text(svg, encoding='utf-8')
        print(f'{relative_path:45} {width:g} x {height:g}')


# ---------------------------------------------------------------- bit fields

@dataclass
class Field:
    text: str
    high_bit: int
    low_bit: int
    color: str = None       # defaults to the colour of its row


@dataclass
class Row:
    color: str
    fields: list            # list of Field
    height: float = 1       # in rows


def fields(*specs):
    """fields(("gc", 31, 30), ("rwds", 29, 26), ...) -> [Field, ...]"""
    return [Field(*spec) for spec in specs]


def is_type_tag(f):
    """Binary literals ending at bit 0 (0111, 11111, …) identify the kind of a word."""
    return f.low_bit == 0 and f.text != '' and set(f.text) <= {'0', '1'}


def type_tag_bits(rows):
    return {bit for row in rows for f in row.fields if is_type_tag(f) for bit in range(f.low_bit, f.high_bit + 1)}


def field_edges(rows):
    """bit -> {'high', 'low'}: whether the bit is the left and/or right end of some field."""
    edges = {}
    for row in rows:
        for f in row.fields:
            edges.setdefault(f.high_bit, set()).add('high')
            edges.setdefault(f.low_bit, set()).add('low')
    return edges


class BitGrid:
    """Horizontal position of every bit column; the highest bit is on the left."""

    def __init__(self, column_width_of_bit):
        self.column_width = column_width_of_bit
        self.left_edge = {}
        x = 0
        for bit in sorted(column_width_of_bit, reverse=True):
            self.left_edge[bit] = x
            x += column_width_of_bit[bit]
        self.width = x

    @classmethod
    def uniform(cls, total_bits, bit_width):
        return cls({bit: bit_width for bit in range(total_bits)})

    @classmethod
    def compressed(cls, numbered_bits, total_bits=32):
        """Full-width columns for numbered bits, narrow ones for the bits in between."""
        return cls({bit: WIDE_BIT if bit in numbered_bits else NARROW_BIT for bit in range(total_bits)})

    def left(self, bit):
        return self.left_edge[bit]

    def right(self, bit):
        return self.left_edge[bit] + self.column_width[bit]


# every bit that is numbered in any of the 32-bit object diagrams
NUMBERED_BITS = {31, 30, 29, 26, 25, 24, 17, 16, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0}
OBJECT_GRID = BitGrid.compressed(NUMBERED_BITS)


def draw_bit_numbers(drawing, x, y, rows, grid):
    """Numbers over field edges and over every bit of a type tag. Centred over the bit
    when its column is wide enough, otherwise aligned to the field edge."""
    edges = field_edges(rows)
    for bit in sorted(set(edges) | type_tag_bits(rows)):
        label = str(bit)
        left, right = x + grid.left(bit), x + grid.right(bit)
        fits_over_column = len(label) * LABEL_TEXT_PX * 0.6 + 2 <= right - left
        sides = edges.get(bit, set())
        if fits_over_column or sides == {'high', 'low'} or not sides:
            drawing.text((left + right) / 2, y, label, 'label')
        elif sides == {'high'}:
            drawing.text(left + 2, y, label, 'label start')
        else:
            drawing.text(right - 2, y, label, 'label end')


def draw_bitfield(drawing, x, y, rows, grid=OBJECT_GRID, with_labels=True):
    """Draws rows of fields on a bit grid; returns the y below the box."""
    if with_labels:
        draw_bit_numbers(drawing, x, y + LABEL_TEXT_PX / 2, rows, grid)
        y += LABEL_TEXT_PX + LABEL_GAP

    top = y
    width = grid.width
    row_tops = []
    for index, row in enumerate(rows):
        height = row.height * ROW_HEIGHT
        if index > 0:
            row_tops.append(y)
        dividers = []
        for f in row.fields:
            left = x + grid.left(f.high_bit)
            right = x + grid.right(f.low_bit)
            color = f.color or row.color
            drawing.rect(left, y, right - left, height, color)
            if f.low_bit > 0:
                dividers.append(right)
            drawing.text((left + right) / 2, y + height / 2, f.text, f'on-{color}')
        for divider_x in dividers:
            drawing.line(divider_x, y, divider_x, y + height)
        y += height
    for row_top in row_tops:
        drawing.line(x, row_top, x + width, row_top)
    drawing.rect(x, top, width, y - top, 'outline')
    return y


def save_bitfield(path, title, rows, **options):
    drawing = Drawing()
    draw_bitfield(drawing, 0, 0, rows, **options)
    drawing.save(path, title)


# ---------------------------------------------------------------- free-form cells

def draw_cell(drawing, x, y, width, text, color, height=ROW_HEIGHT, outline=True):
    drawing.rect(x, y, width, height, color)
    drawing.text(x + width / 2, y + height / 2, text, f'on-{color}')
    if outline:
        drawing.rect(x, y, width, height, 'outline')


def draw_group(drawing, x, y, cells, height=ROW_HEIGHT):
    """Adjacent cells [(width, text, colour), …] with thin dividers and one outline."""
    left = x
    for index, (width, text, color) in enumerate(cells):
        draw_cell(drawing, x, y, width, text, color, height, outline=False)
        if index > 0:
            drawing.line(x, y, x, y + height)
        x += width
    drawing.rect(left, y, x - left, height, 'outline')


def draw_value_or_pointer(drawing, x, y, width, height=ROW_HEIGHT, left_text='val', right_text='ptr', middle_text='or'):
    """A slot that holds either a primitive (blue) or a pointer (pink), split diagonally."""
    slant = height * 0.7
    split = x + width * 0.5
    bottom_x, top_x = split - slant / 2, split + slant / 2
    drawing.polygon([(x, y), (top_x, y), (bottom_x, y + height), (x, y + height)], 'blue')
    drawing.polygon([(top_x, y), (x + width, y), (x + width, y + height), (bottom_x, y + height)], 'pink')
    if middle_text:  # the diagonal leaves a gap for the small "or"
        gap = 0.34
        drawing.line(top_x, y, top_x - slant * gap, y + height * gap, 'diagonal')
        drawing.line(bottom_x + slant * gap, y + height * (1 - gap), bottom_x, y + height, 'diagonal')
        drawing.text(split, y + height / 2, middle_text, 'small')
    else:
        drawing.line(top_x, y, bottom_x, y + height, 'diagonal')
    drawing.text((x + bottom_x) / 2 + 2, y + height / 2, left_text, 'on-blue')
    drawing.text((top_x + x + width) / 2 - 2, y + height / 2, right_text, 'on-pink')


def draw_stack(drawing, x, y, width, rows):
    """Stacked slots of one object. rows: (text, colour), 'split' (val or ptr) or
    'split-any' (an arbitrary slot, "..." on both sides). Returns the bottom y."""
    top = y
    for index, row in enumerate(rows):
        if row == 'split':
            draw_value_or_pointer(drawing, x, y, width)
        elif row == 'split-any':
            draw_value_or_pointer(drawing, x, y, width, left_text='...', right_text='...', middle_text=None)
        else:
            draw_cell(drawing, x, y, width, row[0], row[1], outline=False)
        if index > 0:
            drawing.line(x, y, x + width, y)
        y += ROW_HEIGHT
    drawing.rect(x, top, width, y - top, 'outline')
    return y


def draw_continuation(drawing, x, y):
    """The '…' below an object meaning 'more slots follow'."""
    drawing.text(x, y + 10, '...', 'heading')


# ---------------------------------------------------------------- diagrams: objects in memory (objektbaukasten)

HEADER_ROW_2 = Row('green', fields(('λ(31:2)', 31, 2), ('00', 1, 0)))


def header_row(rw_bits, cf_text):
    return Row('green', fields(('gc', 31, 30), (rw_bits, 29, 26), ('', 25, 7), (cf_text, 6, 5), ('11111', 4, 0)))


def objects_in_memory():
    folder = 'objektbaukasten'
    save_bitfield(f'{folder}/header.svg', 'Header bitmap on 32-bit architectures',
                  [header_row('rwds', 'cf'), HEADER_ROW_2])
    save_bitfield(f'{folder}/data.svg', 'Word, half and byte locations in an ordinary object', [
        Row('blue', fields(('word(30:0)', 31, 1), ('0', 0, 0))),
        Row('blue', fields(('h1(14:0)', 31, 17), ('h0(15:0)', 16, 1), ('0', 0, 0))),
        Row('blue', fields(('b3', 31, 25), ('b2', 24, 17), ('b1', 16, 9), ('b0', 8, 1), ('0', 0, 0))),
    ])
    save_bitfield(f'{folder}/disp_prim_ptr.svg', 'Pointer to displaced data',
                  [Row('purple', fields(('ptr(31:2)', 31, 2), ('01', 1, 0)))])
    save_bitfield(f'{folder}/disp_ptr_ptr.svg', 'Pointer to a displaced pointer',
                  [Row('light-pink', fields(('ptr(31:3)', 31, 3), ('011', 2, 0)))])
    save_bitfield(f'{folder}/pointer.svg', 'Pointer to an object',
                  [Row('pink', fields(('ptr(31:4)', 31, 4), ('0111', 3, 0)))])
    save_bitfield(f'{folder}/io_ptr.svg', 'I/O pointer',
                  [Row('pink', fields(('device', 31, 5), ('01111', 4, 0)))])
    save_bitfield(f'{folder}/ordinary_object.svg', 'Ordinary object and its possible elements', [
        header_row('rw00', 'cf'), HEADER_ROW_2,
        Row('blue', fields(('integer(30:0)', 31, 1), ('0', 0, 0))),
        Row('purple', fields(('ptr(31:2)', 31, 2), ('01', 1, 0))),
        Row('light-pink', fields(('ptr(31:3)', 31, 3), ('011', 2, 0))),
        Row('pink', fields(('ptr(31:4)', 31, 4), ('0111', 3, 0))),
        Row('pink', fields(('device', 31, 5), ('01111', 4, 0))),
    ])
    save_bitfield(f'{folder}/data_only_object.svg', 'Data-only object', [
        header_row('rw10', '00'), HEADER_ROW_2,
        Row('cyan', fields(('integer(31:0)', 31, 0))),
        Row('cyan', fields(('...', 31, 0))),
        Row('cyan', fields(('integer(31:0)', 31, 0))),
    ])
    save_bitfield(f'{folder}/executable_object.svg', 'Executable object', [
        header_row('0010', '00'), HEADER_ROW_2,
        Row('pink', fields(('GOT', 31, 4), ('0111', 3, 0))),
        Row('yellow', fields(('CODE', 31, 0)), height=4),
    ])
    frame_object(f'{folder}/frame_object.svg')


def frame_object(path):
    drawing = Drawing()
    width, index_column = 220, 256
    y = 18
    drawing.text(index_column, y - 10, 'ix', 'heading')
    bottom = draw_stack(drawing, 0, y, width, [('sp', 'pink'), ('ra', 'pink'), 'split-any'])
    for row, index in enumerate(('0', '4', '8')):
        drawing.text(index_column, y + row * ROW_HEIGHT + ROW_HEIGHT / 2, index, 'heading')
    draw_continuation(drawing, width / 2, bottom + 4)
    draw_continuation(drawing, index_column, bottom + 4)
    drawing.save(path, 'A frame object for XLEN=32')


# ---------------------------------------------------------------- diagrams: software objects

def software_objects():
    folder = 'software_objects'
    object1(f'{folder}/object1.svg')
    object2(f'{folder}/object2.svg')
    save_bitfield(f'{folder}/pointer_plus_index.svg', 'Composition of a pointer',
                  [Row('pink', fields(('base', 63, 32), ('index', 31, 0, 'blue')))],
                  grid=BitGrid.uniform(64, 6))
    pointer_arithmetic(folder)


def object1(path):
    drawing = Drawing()
    width, gap = 140, 48
    title_height = 20
    object_x = 2 * (width + gap)
    middle_row_y = title_height + ROW_HEIGHT
    draw_cell(drawing, 0, middle_row_y, width, 'pointer', 'pink')
    draw_cell(drawing, width + gap, middle_row_y, width, 'value', 'blue')
    drawing.text(object_x + width / 2, title_height / 2, 'Object', 'heading')
    bottom = draw_stack(drawing, object_x, title_height, width, ['split'] * 3)
    draw_continuation(drawing, object_x + width / 2, bottom + 4)
    drawing.save(path, 'A pointer, a primitive value and an object')


def object2(path):
    drawing = Drawing()
    width, gap = 140, 40
    columns = [
        ('Ordinary', ['split'] * 4),
        ('Executable', [('code', 'yellow')] * 4),
        ('Data-Only', [('value', 'cyan')] * 4),
    ]
    for column, (title, rows) in enumerate(columns):
        x = column * (width + gap)
        bottom = draw_stack(drawing, x, 0, width, [(title, 'green')] + rows)
        draw_continuation(drawing, x + width / 2, bottom + 4)
    drawing.save(path, 'Ordinary, executable and data-only objects')


def pointer_arithmetic(folder):
    """Column addition of pointers (pink base, blue index) and primitives (blue only)."""
    sums = {
        'prim_plus_prim.svg': [(None, '12'), (None, '34'), (None, '46')],
        'pointer_plus_prim.svg': [(None, '46'), ('A', '12'), ('A', '58')],
        'pointer_plus_pointer_1.svg': [('A', '58'), ('B', '34'), ('A', '1498')],
        'pointer_plus_pointer_2.svg': [('A', '1498'), ('B', '34'), ('B', '90')],
    }
    sign_width, base_width, index_width, gap = 22, 52, 72, 6
    base_x = sign_width
    index_x = base_x + base_width + gap
    right = index_x + index_width
    row_step = ROW_HEIGHT + 12
    for name, (first, second, result) in sums.items():
        drawing = Drawing()
        for row, (base, index) in enumerate((first, second)):
            y = row * row_step
            if base:
                draw_cell(drawing, base_x, y, base_width, base, 'pink')
            draw_cell(drawing, index_x, y, index_width, index, 'blue')
        drawing.text(sign_width / 2 - 2, row_step + ROW_HEIGHT / 2, '+', 'heading')
        rule_y = 2 * row_step - 4
        drawing.line(0, rule_y, right, rule_y, 'rule')
        result_y = rule_y + 10
        if result[0]:
            draw_cell(drawing, base_x, result_y, base_width, result[0], 'pink')
        draw_cell(drawing, index_x, result_y, index_width, result[1], 'blue')
        drawing.save(f'{folder}/{name}', 'Pointer arithmetic: ' + name.removesuffix('.svg').replace('_', ' '))


# ---------------------------------------------------------------- diagram: register file

def register_file(path):
    """Registers of the example implementation: ISA part (tag, pointer, index/value) and
    IMP part (copied header flags and the object length λ)."""
    drawing = Drawing()
    name_width, tag_width, wide, flag = 58, 22, 180, 22
    gap = 8
    tag_x = name_width
    pointer_x = tag_x + tag_width + gap
    index_x = pointer_x + wide
    separator_x = index_x + wide + gap
    flags_x = separator_x + gap
    color_x = flags_x + 3 * flag + gap
    length_x = color_x + flag + gap
    right = length_x + wide

    group_y, heading_y, first_row_y = 8, 30, 44
    drawing.text((tag_x + index_x + wide) / 2, group_y, 'ISA', 'heading')
    drawing.text((flags_x + right) / 2, group_y, 'IMP', 'heading')
    headings = [(tag_x + tag_width / 2, 'Tag'), (pointer_x + wide / 2, 'Pointer'), (index_x + wide / 2, 'Index / Value'),
                (flags_x + flag / 2, 'r'), (flags_x + flag * 1.5, 'w'), (flags_x + flag * 2.5, 'd'),
                (color_x + flag / 2, 'c'), (length_x + wide / 2, 'λ')]
    for x, text in headings:
        drawing.text(x, heading_y, text, 'heading')

    # name, tag, (pointer, colour), (index, colour), r w d, colour bit c (None = no cell), λ
    registers = [
        ('zero', '0', ('0', 'white'), ('0', 'blue'), '000', None, '0'),
        ('ra', '1', ('ra.pointer', 'pink'), ('ra.index', 'pink'), '001', None, 'ra.lambda'),
        ('sp', '1', ('sp.pointer', 'pink'), ('sp.index', 'pink'), '110', 'x', 'sp.lambda'),
        ('gp', '1', ('got.pointer', 'pink'), ('0', 'pink'), '1x0', None, 'got.lambda'),
        ('x4-x31', 'x', ('x', 'white'), ('x', 'white'), 'xxx', None, 'x'),
    ]
    row_gap = 8
    y = first_row_y
    for name, tag, (pointer, pointer_color), (index, index_color), flags, color_bit, length in registers:
        drawing.text(name_width - 8, y + ROW_HEIGHT / 2, name, 'heading end')
        draw_cell(drawing, tag_x, y, tag_width, tag, 'white')
        draw_group(drawing, pointer_x, y, [(wide, pointer, pointer_color), (wide, index, index_color)])
        draw_group(drawing, flags_x, y, [(flag, value, 'green') for value in flags])
        if color_bit:
            draw_cell(drawing, color_x, y, flag, color_bit, 'white')
        draw_cell(drawing, length_x, y, wide, length, 'green')
        y += ROW_HEIGHT + row_gap
    drawing.line(separator_x, 0, separator_x, y - row_gap + 4, 'divider dashed')
    drawing.save(path, 'An example implementation of a RISC-ViO register file')


if __name__ == '__main__':
    objects_in_memory()
    software_objects()
    register_file('register_file.svg')
