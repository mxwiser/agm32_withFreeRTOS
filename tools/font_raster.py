"""Rasterize a small OFL Noto Sans SC subset directly at its target size."""
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_FONT = "C:/Windows/Fonts/NotoSansSC-VF.ttf"


def generate_font(name, size, characters, weight=600, font_path=DEFAULT_FONT):
    font = ImageFont.truetype(font_path, size)
    try:
        font.set_variation_by_axes([weight])
    except (OSError, AttributeError):
        pass  # A non-variable Noto Sans SC with the desired weight also works.

    codepoints = sorted(set(map(ord, characters)))
    if not codepoints or codepoints[-1] - codepoints[0] >= 65535:
        raise ValueError("The subset must fit a single 16-bit character map")
    bitmap = bytearray()
    descriptors = ["    {0}, /* reserved */"]
    for cp in codepoints:
        char = chr(cp)
        left, top, right, bottom = font.getbbox(char, anchor="ls")
        width, height = right - left, bottom - top
        start = len(bitmap)
        if width and height:
            image = Image.new("L", (width, height))
            ImageDraw.Draw(image).text((-left, -top), char, font=font, fill=255, anchor="ls")
            alpha = [(value + 8) // 17 for value in image.tobytes()]
            for i in range(0, len(alpha), 2):
                bitmap.append((alpha[i] << 4) | (alpha[i + 1] if i + 1 < len(alpha) else 0))
        descriptors.append(
            "    {.bitmap_index = %d, .adv_w = %d, .box_w = %d, .box_h = %d, .ofs_x = %d, .ofs_y = %d}, /* U+%04X */"
            % (start, round(font.getlength(char) * 16), width, height, left, -bottom, cp)
        )

    rows = ["    " + ", ".join(f"0x{x:02x}" for x in bitmap[i:i + 16]) + ","
            for i in range(0, len(bitmap), 16)]
    start = codepoints[0]
    mapping = ", ".join(f"0x{cp - start:04x}" for cp in codepoints)
    asc, desc = font.getmetrics()
    result = '''/* Generated at native %d px, weight %d; no bitmap scaling.
 * Source: Noto Sans SC, Copyright 2014-2021 Adobe; SIL OFL 1.1.
 * See OFL-1.1.txt in this directory. */
#include "lvgl.h"

static const uint8_t glyph_bitmap[] __attribute__((section(".flash.font"))) = {
%s
};
static const lv_font_fmt_txt_glyph_dsc_t glyph_dsc[] = {
%s
};
static const uint16_t unicode_list[] = {%s};
static const lv_font_fmt_txt_cmap_t cmaps[] = {
    {.range_start = %d, .range_length = %d, .glyph_id_start = 1,
     .unicode_list = unicode_list, .glyph_id_ofs_list = NULL, .list_length = %d,
     .type = LV_FONT_FMT_TXT_CMAP_SPARSE_TINY}
};
static const lv_font_fmt_txt_dsc_t font_dsc = {
    .glyph_bitmap = glyph_bitmap, .glyph_dsc = glyph_dsc, .cmaps = cmaps,
    .kern_dsc = NULL, .kern_scale = 0, .cmap_num = 1, .bpp = 4,
    .kern_classes = 0, .bitmap_format = 0
};
const lv_font_t %s = {
    .get_glyph_dsc = lv_font_get_glyph_dsc_fmt_txt,
    .get_glyph_bitmap = lv_font_get_bitmap_fmt_txt,
    .line_height = %d, .base_line = %d,
    .subpx = LV_FONT_SUBPX_NONE, .underline_position = -2,
    .underline_thickness = 1, .static_bitmap = 1,
    .dsc = &font_dsc, .fallback = NULL, .user_data = NULL
};
''' % (size, weight, "\n".join(rows), "\n".join(descriptors), mapping,
       start, codepoints[-1] - start + 1, len(codepoints), name, asc + desc, desc)
    target = ROOT / f"user/user_fonts/{name}.c"
    target.write_text(result, encoding="utf-8", newline="\n")
    print(f"Generated {target}: {len(codepoints)} glyphs, {len(bitmap)} bitmap bytes")
