#!/usr/bin/env python3

# Stdlib imports
import os
import json

# Internal imports

# 3rd party imports
from bottle import run, route, template


def input_out(d):
    retv = {}
    for k, v in d.items():
        if type(v) in (int, float):
            retv[k] = {"type": "number", "value": v}
        elif type(v) == bool:
            retv[k] = {"type": "checkbox", "value": v}
        else:
            retv[k] = {"type": "text", "value": v}
    return retv


@route("/")
def index():
    retv = {"in_out": input_out}
    if os.path.isfile("goslice.json"):
        with open("goslice.json", "r") as fp:
            retv.update(json.loads(fp.read()))
    return template("index", data=retv)


if __name__ == "__main__":
    run(host="0.0.0.0", port=8080, reloader=True, debug=True)

# <html>
#   <head>
#     <title>The Print Farm</title>
#   </head>
#   <body style="width:30%;margin:auto;">
#     <form action="http://localhost:9999/stl" enctype="multipart/form-data" method="post">
#       <label for="fname">Filename:</label>
#       <input type="file" id="fname" name="fname" /><br />
#     </form>
#   </body>
# </html>
