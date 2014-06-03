object testing
isCompiledMethod: objOop
    "Answer whether the argument object is of compiled method format"
	<api>
    ^(self formatOf: objOop) >= 24