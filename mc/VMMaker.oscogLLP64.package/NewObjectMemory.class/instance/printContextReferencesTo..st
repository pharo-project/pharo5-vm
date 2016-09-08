debug printing
printContextReferencesTo: anOop
	"Scan the heap printing the oops of any and all contexts that refer to anOop"
	| oop i |
	<api>
	oop := self firstAccessibleObject.
	[oop = nil] whileFalse:
		[(self isContextNonImm: oop) ifTrue:
			[i := CtxtTempFrameStart + (coInterpreter fetchStackPointerOf: oop)].
			 [(i := i - 1) >= 0] whileTrue:
				[anOop = (self fetchPointer: i ofObject: oop) ifTrue:
					[coInterpreter
						printHex: oop; print: ' @ '; printNum: i; space; printOopShort: oop;
						print: ' pc '; printHex: (self fetchPointer: InstructionPointerIndex ofObject: oop); cr.
					 i := 0]].
		 oop := self accessibleObjectAfter: oop]