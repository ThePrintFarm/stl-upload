#!/usr/bin/env python3

# Stdlib imports
import os
import json

# Internal imports

# 3rd party imports
from bottle import run, route, template


def json2form(d):
    retv = {}
    for k, v in d.items():
        if type(v) in (int, float):
            retv[k] = {"type": "number", "value": v}
        elif type(v) == bool:
            retv[k] = {"type": "checkbox", "value": v}
        elif type(v) == dict:
            retv[k] = {"type": "fieldset", "value": json2form(v)}
        elif type(v) in (list, tuple):
            retv[k] = {"type": "select", "value": json2form(v)}
        else:
            retv[k] = {"type": "text", "value": v}
    return retv


@route("/goslice")
def goslice():
    retv = {"json2form": json2form}
    if os.path.isfile("goslice.json"):
        with open("goslice.json", "r") as fp:
            retv.update(json.loads(fp.read()))
    return template(
        "index",
        data=retv,
        engine="goslice",
        endpoint=os.getenv("SLICER_ENDPOINT", "localhost:9999"),
    )


@route("/cura")
def cura():
    retv = {"json2form": json2form}
    if os.path.isfile("cura.csv"):
        # call the translate service and upload this settings file, then
        # use the return value to populate the template data
        pass
    return template("index", data=retv, engine="cura")


@route("/prusa")
def prusa():
    retv = {"json2form": json2form}
    if os.path.isfile("prusa.ini"):
        # call the translate service and upload this settings file, then
        # use the return value to populate the template data
        pass
    return template("index", data=retv, engine="prusa")


@route("/")
def index():
    return template("index", data={"json2form": json2form})


if __name__ == "__main__":
    host = os.getenv("HOST", "0.0.0.0")
    port = os.getenv("PORT", 8080)
    run(host=host, port=port, reloader=True, debug=True)

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
