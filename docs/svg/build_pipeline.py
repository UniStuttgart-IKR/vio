"""Redraws the legacy RISC-ViO pipeline (pipeline.svg, Inkscape) with the changes of the meeting of 2026-07-15.

Unchanged parts (IF, DC, forwarding, ALU, DBU, the RD path of ME, the boxing stage) are kept verbatim.
Removed: combined PGU & AGU, DPU, the MALC field of the DC/EX register and the MALC loop.
Added: separate AGU and PGU, MPRG/MALC/MSAD/MLIM registers, attribute cache with bounds check,
SAD, frame clearing engine (FrmClr), sanctuary cache in the boxing stage, MALC/MSAD commit loops.
All new elements use absolute coordinates in Layer 1 and the styles and markers of the legacy file.
"""
import sys
from lxml import etree

SRC = sys.argv[1] if len(sys.argv) > 1 else '/mnt/user-data/uploads/pipeline.svg'
DST = sys.argv[2] if len(sys.argv) > 2 else '/mnt/user-data/outputs/pipeline.svg'

SVG = 'http://www.w3.org/2000/svg'
INK = 'http://www.inkscape.org/namespaces/inkscape'
SODI = 'http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd'

tree = etree.parse(SRC)
root = tree.getroot()
by_id = {el.get('id'): el for el in root.iter() if el.get('id')}
layer = by_id['layer1']


def delete(*ids):
    for i in ids:
        el = by_id[i]
        el.getparent().remove(el)


def rename_text(group_id, old, new):
    """Replaces the text of a field label inside a register group."""
    hits = 0
    for t in by_id[group_id].iter('{%s}tspan' % SVG, '{%s}text' % SVG):
        if t.text and t.text.strip() == old:
            t.text = new
            hits += 1
    assert hits == 1, (group_id, old, hits)


def find_text(group_id, content):
    for t in by_id[group_id].iter('{%s}text' % SVG):
        if ''.join(t.itertext()).strip() == content:
            return t
    raise KeyError(content)


# ------------------------------------------------------------------ canvas: room for the CSR registers and loops
HEIGHT = 815
root.set('height', f'{HEIGHT}mm')
root.set('viewBox', f'0 0 2500 {HEIGHT}')

# ------------------------------------------------------------------ removals
delete('rect5-1', 'text5-0-8')                     # combined PGU & AGU
delete('path83')                                   # DC/EX MALC field into the MALC mux
delete('path28')                                   # pgu_mode into the combined block (rerouted to the PGU)
malc_dc = find_text('g5-8', 'MALC')
malc_dc.getparent().remove(malc_dc)
delete('rect16-7-9')                               # its white label background
delete('rect5-1-7-9', 'text5-0-5-8',               # DPU and its wiring
       'path74', 'path75', 'path76', 'path77', 'path78', 'path79', 'path80', 'path81', 'path87', 'path88',
       'text6-20', 'text6-20-8', 'text6-20-8-5', 'text6-20-8-5-2', 'text6-20-8-5-6',
       'path92', 'path93', 'path112', 'path113', 'path114', 'path115', 'path116', 'path118', 'path119',
       'path121', 'path122', 'path122-1', 'path122-1-3', 'path124', 'path125', 'path126')
delete('path142')                                  # legacy MALC loop

# ------------------------------------------------------------------ renames: the attribute stage became the boxing stage
for group in ('g5-8', 'g5-8-7', 'g5-8-7-3'):
    rename_text(group, 'fwd_as', 'fwd_bx')
    rename_text(group, 'as_rd_sel', 'bx_rd_sel')
for old in ('as_addr', 'as_mode', 'as_wdata'):
    rename_text('g5-8-7-3', old, 'bx_' + old[3:])
title = by_id['text5-0-5-8-8-9']
spans = title.findall('{%s}tspan' % SVG)
title.remove(spans[0])
spans[1].text = 'Sanctuary'
spans[2].text = 'Cache'
title.remove(spans[3])
by_id['g137'].set('{%s}label' % INK, 'bx_stage')
by_id['g5-8-7-3-5'].set('{%s}label' % INK, 'bx_reg')

by_id['path57'].set('d', 'M 981.99997,489.99999 H 1010 v 150 H 30 V 490 h 44')
by_id['path56'].set('d', 'm 981.99997,499.99999 h 18 v 130 H 86 V 529')
by_id['path55'].set('d', 'm 978.96835,371.29339 h 21 v -142 h 36.99995')

# ------------------------------------------------------------------ drawing helpers in the legacy styles
WIRE = 'fill:none;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter'
ARROW = WIRE + ';marker-end:url(#RoundedArrow-7-2)'
BOX = 'fill:#f9f9f9;fill-opacity:1;stroke:#000000;stroke-width:2;stroke-linecap:square;stroke-linejoin:miter'
REG = 'fill:#ececec;stroke:#000000;stroke-width:2;stroke-linecap:square;stroke-linejoin:miter'
FIELD = 'fill:#ffffff;fill-opacity:1;stroke:none'
FONT = "font-family:Consolas;-inkscape-font-specification:'Consolas, {w}'"
TITLE = 'font-style:normal;font-weight:bold;font-size:12.7px;line-height:1;' + FONT.format(w='Bold') + ';text-anchor:middle;text-align:center;fill:#000000;stroke:none'
SMALL_TITLE = TITLE.replace('12.7px', '8.5px')
FIELD_TEXT = 'font-style:normal;font-weight:bold;font-size:7.05px;line-height:1;' + FONT.format(w='Bold') + ';text-anchor:middle;text-align:center;fill:#000000;stroke:none'
LABEL = 'font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1;' + FONT.format(w='Normal') + ';text-anchor:start;fill:#000000;stroke:none'
SOLID = 'fill:#000000;fill-opacity:1;stroke:none'

counter = [0]


def new_id(prefix):
    counter[0] += 1
    return f'{prefix}-vio{counter[0]}'


def group(label):
    g = etree.SubElement(layer, '{%s}g' % SVG, id=new_id('g'))
    g.set('{%s}label' % INK, label)
    return g


def path(g, d, style=ARROW):
    return etree.SubElement(g, '{%s}path' % SVG, d=d, style=style, id=new_id('path'))


def wire(g, *points, arrow=True):
    d = 'M ' + ' '.join(f'{x:g},{y:g}' for x, y in points)
    return path(g, d, ARROW if arrow else WIRE)


def dot(g, x, y):
    etree.SubElement(g, '{%s}circle' % SVG, cx=f'{x:g}', cy=f'{y:g}', r='1.6', style=SOLID, id=new_id('circle'))


def rect(g, x, y, w, h, style):
    return etree.SubElement(g, '{%s}rect' % SVG, x=f'{x:g}', y=f'{y:g}', width=f'{w:g}', height=f'{h:g}', style=style, id=new_id('rect'))


def text(g, x, y, lines, style):
    t = etree.SubElement(g, '{%s}text' % SVG, x=f'{x:g}', y=f'{y:g}', style=style, id=new_id('text'))
    t.set('{http://www.w3.org/XML/1998/namespace}space', 'preserve')
    step = 12.7 if '12.7px' in style else 9
    for i, line in enumerate(lines if isinstance(lines, list) else [lines]):
        s = etree.SubElement(t, '{%s}tspan' % SVG, x=f'{x:g}', y=f'{y + i * step:g}', id=new_id('tspan'))
        s.set('{%s}role' % SODI, 'line')
        s.text = line
    return t


def box(g, x, y, w, h, lines, style=BOX, title=TITLE):
    rect(g, x, y, w, h, style)
    lines = lines if isinstance(lines, list) else [lines]
    step = 12.7 if title is TITLE else 9
    size = 12.7 if title is TITLE else 8.5
    text(g, x + w / 2, y + h / 2 - (len(lines) - 1) * step / 2 + size * 0.35, lines, title)


def field(g, x, y, name):
    """A field label of a pipeline register (register body from x to x + 40)."""
    rect(g, x + 1, y, 38, 10, FIELD)
    text(g, x + 20, y + 7.6, name, FIELD_TEXT)


def csr(g, x, y, name):
    """A small clocked register, like the pipeline registers with the clock at the bottom."""
    rect(g, x, y, 60, 25, REG)
    path(g, f'M {x + 25:g},{y + 25:g} L {x + 30:g},{y + 18:g} L {x + 35:g},{y + 25:g} Z', SOLID)
    text(g, x + 30, y + 13.5, name, SMALL_TITLE)


def mux(g, x, y, h, w=6):
    path(g, f'M {x:g},{y:g} V {y + h:g} l {w:g},-{w:g} V {y + w:g} Z', SOLID)


def circle(g, x, y, symbol):
    etree.SubElement(g, '{%s}circle' % SVG, cx=f'{x:g}', cy=f'{y:g}', r='6', style='fill:#f9f9f9;stroke:#000000;stroke-width:1', id=new_id('circle'))
    text(g, x, y + 3, symbol, FIELD_TEXT.replace('7.05px', '9px'))


def label(g, x, y, s):
    text(g, x, y, s, LABEL)


# ------------------------------------------------------------------ IF: instruction cache
ifs = group('if_stage')
box(ifs, 195, 330, 105, 130, ['INSTRUCTION', 'CACHE'])
dot(ifs, 175, 504.6)
wire(ifs, (175, 504.6), (175, 440), (191, 440))
label(ifs, 178, 437, 'pc(31:0)')
wire(ifs, (301, 399.6), (334, 399.6))
label(ifs, 303, 397, 'instruction')
field(ifs, 338, 394.6, 'INSTR')

# ------------------------------------------------------------------ DC: register file read ports
dc = group('dc_stage_ports')
for y in (120, 130):
    wire(dc, (523, y), (714, y))
    label(dc, 600, y - 1.5, '32+32+1')

# ------------------------------------------------------------------ EX: AGU and PGU instead of the combined block
ex = group('ex_stage_units')
box(ex, 884, 341, 97, 56, 'AGU')
box(ex, 884, 401, 97, 53, 'PGU')
wire(ex, (760, 350), (805, 350), (805, 410), (880, 410))           # pgu_mode now reaches the PGU
wire(ex, (982, 360), (1105, 360))                                  # me_base
field(by_id['layer1'], 1109, 355, 'me_base')

# ------------------------------------------------------------------ MPRG, MLIM, MALC, MSAD: fields of the DC/EX register
regs = group('dc_ex_fields')
for y, name in ((475, 'MPRG'), (485, 'MLIM'), (545, 'MALC'), (555, 'MSAD')):
    field(regs, 718, y, name)
# MALC into the MALC forwarding mux (which keeps its forwarded input)
wire(regs, (760, 550), (790, 550))
# MSAD to the PGU and down the pipeline
wire(regs, (760, 560), (1095, 560), (1095, 545), (1105, 545))
dot(regs, 876, 560)
wire(regs, (876, 560), (876, 425), (880, 425))
# MLIM to the PGU, for the heap overflow check
wire(regs, (760, 490), (869, 490), (869, 432), (880, 432))
# MPRG to FrmClr
wire(regs, (760, 480), (812, 480), (812, 760), (1185, 760), (1185, 694))
label(regs, 1100, 758, 'mprg')
# next MPRG: reset to the old sp (rs1) by lw sp, 0(sp), or advanced by FrmClr
mux(regs, 704, 470, 20)
dot(regs, 694, 120)
wire(regs, (694, 120), (694, 474), (700, 474))
rot = text(regs, 691, 330, 'rs1: lw sp, 0(sp)', LABEL)
rot.set('transform', 'rotate(-90 691 330)')
for s_ in rot:
    s_.set('x', '691'); s_.set('y', '330')
wire(regs, (1245, 672.5), (1265, 672.5), (1265, 770), (688, 770), (688, 486), (700, 486))
label(regs, 1100, 768, 'advance')
wire(regs, (710, 480), (714, 480))

# ------------------------------------------------------------------ ME: attribute cache with bounds and rights check
me = group('me_stage_units')
box(me, 1165, 250, 80, 70, 'ATTR')
# base into the attribute cache and into the adder
wire(me, (1150, 360), (1158, 360), (1158, 290), (1161, 290))
dot(me, 1158, 335)
wire(me, (1158, 335), (1262, 335), (1262, 280))
label(me, 1166, 333, 'base')
# header writes of alc: object address, alc_λ, is_alc; access mode for the rights check
dot(me, 1176, 535)
wire(me, (1176, 535), (1176, 324))
wire(me, (1150, 490), (1185, 490), (1185, 324))
wire(me, (1150, 500), (1193, 500), (1193, 324))
dot(me, 1215, 380)
wire(me, (1215, 380), (1215, 324))
# len + base, compared with the access address
wire(me, (1245, 270), (1252, 270))
label(me, 1246, 267, 'len')
circle(me, 1262, 270, '+')
wire(me, (1268, 270), (1280, 270))
circle(me, 1290, 270, '<')
dot(me, 1290, 370)
wire(me, (1290, 370), (1290, 280))
wire(me, (1296, 270), (1312, 270))
label(me, 1299, 266, 'in_bounds')
wire(me, (1240, 250), (1240, 210), (1465, 210))
label(me, 1300, 208, 'attr')
dot(me, 1225, 480)
wire(me, (1225, 480), (1225, 324))
# exceptions of the bounds and rights check
wire(me, (1205, 250), (1205, 244))
label(me, 1209, 247, 'exc')
# store data or, for a displaced store, the displacement pointer from MSAD
mux(me, 1295, 390, 22)
wire(me, (1150, 480), (1279, 480), (1279, 395), (1291, 395))
dot(me, 1286, 545)
wire(me, (1286, 545), (1286, 406), (1291, 406))
wire(me, (1301, 401), (1312, 401))
# memory bus for read-through and write-through accesses
wire(me, (1435, 395), (1462, 395))
label(me, 1437, 392, 'memory bus')
# SAD: activates on displacement, allocates sanctuary slots, updates MSAD (and MALC)
box(me, 1340, 440, 90, 115, 'SAD')
wire(me, (1385, 415), (1385, 436))
label(me, 1388, 427, 'disp')
wire(me, (1150, 525), (1336, 525))
label(me, 1300, 523, 'malc_upd')
wire(me, (1150, 535), (1336, 535))
wire(me, (1150, 545), (1336, 545))
wire(me, (1340, 450), (1298, 450), (1298, 416))
label(me, 1302, 448, 'displace')
for y, name in ((455, 'bx_addr'), (465, 'bx_mode'), (475, 'bx_wdata'), (535, 'MALC'), (545, 'MSAD')):
    wire(me, (1431, y), (1517, y))
# frame clearing engine: clears one cache row per cycle without load or store, at MPRG
box(me, 1165, 655, 80, 35, 'FrmClr')
wire(me, (1205, 655), (1205, 600), (1322, 600), (1322, 418))
label(me, 1210, 597, 'row_clr')

# ------------------------------------------------------------------ registers: new fields
fields = group('register_fields')
field(fields, 1521, 540, 'MSAD')              # ME/BX
field(fields, 1941, 540, 'MSAD')              # final register
wire(fields, (1562, 545), (1937, 545))

# ------------------------------------------------------------------ commit loops of MALC and MSAD
loops = group('commit_loops')
wire(loops, (1982, 535), (2015, 535), (2015, 800), (676, 800), (676, 550), (714, 550))
wire(loops, (1982, 545), (2005, 545), (2005, 785), (682, 785), (682, 560), (714, 560))

tree.write(DST, xml_declaration=True, encoding='UTF-8', standalone=False)
print('written', DST)
