debug printing
printMethodImplementorsOf: anOop
	"Scan the heap printing the oops of any and all methods that implement anOop"
	<api>
	self allObjectsDo:
		[:obj|
		 ((self isCompiledMethod: obj)
		  and: [(coInterpreter maybeSelectorOfMethod: obj) = anOop]) ifTrue:
			[coInterpreter printHex: obj; space; printOopShort: obj; cr]]