#!/usr/bin/env python3

import base64
import os
import sys

html_template = """\
<link rel="apple-touch-icon" sizes="{icon_size}" href="data:image/png;base64,{encoded_png}" />
"""


def gen_css(png_file_name, html_file_name, icon_size):
    with open(png_file_name, "rb") as png_file:
        encoded_png = base64.b64encode(png_file.read())
    encoded_png = encoded_png.decode()
    html = html_template.format(icon_size=icon_size, encoded_png=encoded_png)
    with open(html_file_name, "w") as html_file:
        html_file.write(html)

if __name__ == "__main__":
    png_file_name = sys.argv[1]
    html_file_name = sys.argv[2]
    icon_size = sys.argv[3]
    gen_css(png_file_name, html_file_name, icon_size)
    
