debug printing
printContextReferencesTo: anOop
	"Scan the heap printing the oops of any and all contexts that refer to anOop"
	<api>
	self allObjectsDo:
		[:obj| | i |
		 (self isContextNonImm: obj) ifTrue:
			[i := CtxtTempFrameStart + (coInterpreter fetchStackPointerOf: obj).
			 [(i := i - 1) >= 0] whileTrue:
				[anOop = (self fetchPointer: i ofObject: obj) ifTrue:
					[coInterpreter
						printHex: obj; print: ' @ '; printNum: i; space; printOopShort: obj;
						print: ' pc '; printHex: (self fetchPointer: InstructionPointerIndex ofObject: obj); cr.
					 i := 0]]]]