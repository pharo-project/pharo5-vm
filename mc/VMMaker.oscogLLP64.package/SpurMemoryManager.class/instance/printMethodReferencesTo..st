debug printing
printMethodReferencesTo: anOop
	"Scan the heap printing the oops of any and all methods that refer to anOop"
	<api>
	self allObjectsDo:
		[:obj| | i |
		 (self isCompiledMethod: obj) ifTrue:
			[i := (self literalCountOf: obj) + LiteralStart - 1.
			[(i := i - 1) >= 0] whileTrue:
				[anOop = (self fetchPointer: i ofObject: obj) ifTrue:
					[coInterpreter printHex: obj; print: ' @ '; printNum: i; space; printOopShort: obj; cr.
					 i := 0]]]]