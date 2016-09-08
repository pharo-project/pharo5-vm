interpreter access
isCompiledMethod: oop
    "Answer whether the argument object is of compiled method format"
	<api>
    ^(self formatOf: oop) >= self firstCompiledMethodFormat