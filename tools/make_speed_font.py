"""Generate the bold 58 px speed digits directly from OFL Noto Sans SC.

Requires Pillow; --font may specify another local Noto Sans SC font file.
"""
import argparse
from font_raster import DEFAULT_FONT, generate_font

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--font", default=DEFAULT_FONT)
    args = parser.parse_args()
    generate_font("font_speed_58", 58, "0123456789", weight=700, font_path=args.font)
