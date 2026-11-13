"""Generate 14 px text and 24 px value fonts directly from OFL Noto Sans SC.

Requires Pillow; --font may specify another local Noto Sans SC font file.
"""
import argparse
from font_raster import DEFAULT_FONT, generate_font

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--font", default=DEFAULT_FONT)
    args = parser.parse_args()
    generate_font("font_dashboard_14", 14, "".join(chr(x) for x in range(32, 127)) + "°",
                  weight=600, font_path=args.font)
    generate_font("font_dashboard_24", 24, " -0123456789.VAW", weight=650, font_path=args.font)
