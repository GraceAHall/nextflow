

from typing import Optional, List, Dict, Any

File = str
String = str
Int = int
Filename = str
Float = float
Double = float
Boolean = str
Directory = str
Stdout = str
Stderr = str
Array = List
class PythonTool:
    File = str
    Directory = str

def code_block(inp1: File, inp2: String, inp3: Int) -> dict:
    from shutil import copyfile

    copyfile(inp1, "./out.file")

    return {"out": "./out.file"}

