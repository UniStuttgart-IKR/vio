"""
Post-processes draw.io SVG exports so they match the generated diagrams
(see make_diagrams.py). Run it after every export:

    python3 beautify_drawio.py

It is safe to run more than once. For every *.drawio.svg next to this script it

  1. strips the embedded draw.io source (`content=`) and image links, as before,
  2. switches the labels to the shared monospace font (slightly smaller,
     so labels keep their width and still fit their boxes),
  3. thins extra-heavy outlines (3px → 2px, the outline weight used everywhere),
  4. keeps colours that carry meaning unchanged in dark mode (see below),
  5. sets the display size so labels come out at about 13px, like the generated diagrams.
"""
import re
from pathlib import Path

HERE = Path(__file__).parent

DIAGRAM_FONT = '&quot;Roboto Mono&quot;, ui-monospace, &quot;SF Mono&quot;, Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace'

# Proportional fonts are narrower than monospace ones; this factor keeps labels about as wide as before.
FONT_SIZE_FACTOR = {'Helvetica': 0.92, 'Courier New': 1.0}

HEAVIEST_STROKE = 2

# draw.io labels are 12px (11px after the font switch); shown 1.2x they match the 13px
# of the generated diagrams. The heap drawings use tiny 7-8px labels, hence more.
DISPLAY_SCALE = 1.2
DISPLAY_SCALE_PER_FILE = {
    'vio_heap_growth.drawio.svg': 1.7,
    'vio_heap_overflow.drawio.svg': 1.7,
}

# draw.io inverts every colour in dark mode. In these diagrams the black and white
# fills *are* the information (the colour tags of ra and sp), so they keep their
# light-mode value. Keyed by file name; values are the light-mode colours to keep.
COLOUR_TAGS = ['rgb(0, 0, 0)', 'rgb(238, 238, 238)']   # "black" and "white"
KEEP_IN_DARK_MODE = {
    'vio_stack_colors.drawio.svg': COLOUR_TAGS,
    'vio_stack_colors_exception.drawio.svg': COLOUR_TAGS,
}


def strip_drawio_source(svg):
    svg = re.sub(r'content=".+?"', '', svg)
    return re.sub(r'xlink:href=".+?"', '', svg)


def use_diagram_font(svg):
    """Replaces Helvetica / Courier New in label styles and scales their font size."""
    def restyle(match):
        style = match.group(0)
        family = re.search(r'font-family: &quot;(Helvetica|Courier New)&quot;', style)
        if not family:
            return style
        factor = FONT_SIZE_FACTOR[family.group(1)]
        style = style.replace(family.group(0), f'font-family: {DIAGRAM_FONT}')
        return re.sub(r'font-size: ([\d.]+)px',
                      lambda size: f'font-size: {round(float(size.group(1)) * factor * 2) / 2:g}px', style)
    return re.sub(r'style="[^"]*"', restyle, svg)


def limit_stroke_width(svg):
    def thinner(match):
        return f'stroke-width="{min(float(match.group(1)), HEAVIEST_STROKE):g}"'
    return re.sub(r'stroke-width="([\d.]+)"', thinner, svg)


def keep_colours_in_dark_mode(svg, colours):
    """fill: light-dark(<colour>, <dark colour>) → fill: <colour> for the listed colours."""
    for colour in colours:
        svg = re.sub(rf'fill: light-dark\({re.escape(colour)}, rgb\([^)]*\)\)', f'fill: {colour}', svg)
    return svg


def set_display_size(svg, scale):
    """width/height = viewBox size x scale. Computed from the viewBox, so re-running never compounds."""
    view_box = re.search(r'viewBox="[-\d.]+ [-\d.]+ ([\d.]+) ([\d.]+)"', svg)
    if not view_box:
        return svg
    width, height = (round(float(value) * scale) for value in view_box.groups())
    root = re.search(r'<svg\b[^>]*>', svg).group(0)
    resized = re.sub(r'\swidth="[^"]*"', f' width="{width}px"', root, count=1)
    resized = re.sub(r'\sheight="[^"]*"', f' height="{height}px"', resized, count=1)
    return svg.replace(root, resized, 1)


def beautify(path):
    svg = path.read_text(encoding='utf-8')
    svg = strip_drawio_source(svg)
    svg = use_diagram_font(svg)
    svg = limit_stroke_width(svg)
    svg = keep_colours_in_dark_mode(svg, KEEP_IN_DARK_MODE.get(path.name, []))
    svg = set_display_size(svg, DISPLAY_SCALE_PER_FILE.get(path.name, DISPLAY_SCALE))
    path.write_text(svg, encoding='utf-8')
    print(f'beautified {path.name}')


if __name__ == '__main__':
    for drawio_svg in sorted(HERE.glob('*.drawio.svg')):
        beautify(drawio_svg)
