#!/usr/bin/env python3

import base64
import os
import sys

css_template = """\
.{css_class:15} {{ background-image: url(data:image/png;base64,{encoded_png}); }}
"""


def gen_css(png_file_name, css_file_name):
    with open(png_file_name, "rb") as png_file:
        encoded_png = base64.b64encode(png_file.read())
    encoded_png = encoded_png.decode()
    png_file_dirname = os.path.dirname(png_file_name)
    css_class = os.path.basename(png_file_dirname)
    css = css_template.format(css_class=css_class, encoded_png=encoded_png)
    with open(css_file_name, "w") as css_file:
        css_file.write(css)

if __name__ == "__main__":
    png_file_name = sys.argv[1]
    css_file_name = sys.argv[2]
    gen_css(png_file_name, css_file_name)
    
