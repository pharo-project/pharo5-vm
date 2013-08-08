interpreter access
isCompiledMethodHeader: objHeader
    "Answer whether the argument header has compiled method format"
    ^(self formatOfHeader: objHeader) >= 12