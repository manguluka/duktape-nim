# Package
version       = "0.1.0"
author        = "Manguluka Kakia"
packageName   = "duktape"
description   = "wrapper for the Duktape embeddable Javascript engine"
license       = "MIT"

# Dependencies

requires "nimgen >= 0.1.4"

skipDirs = @["tests","src"]
installDirs = @["duktape"]

# Dependencies
import distros

var cmd = ""
if detectOs(Windows):
    cmd = "cmd /c "

task setup, "Download and generate":
    # exec cmd & "/bin/cp -r duktape-2.2.1/src/* nim_duktape/src && nimgen nim_duktape.cfg"
    exec cmd & "nimgen duktape.cfg"

before install:
    setupTask()

task test, "Test duktape":
    exec "nim c -r tests/basic_eval.nim"
    exec "nim c -r tests/bind_proc.nim"