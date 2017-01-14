debug printing
printContextReferencesTo: anOop
	"Scan the heap printing the oops of any and all contexts that refer to anOop"
	| oop i |
	<api>
	oop := self firstAccessibleObject.
	[oop = nil] whileFalse:
		[(self isContextNonImm: oop) ifTrue:
			[i := CtxtTempFrameStart + (self fetchStackPointerOf: oop)].
			 [(i := i - 1) >= 0] whileTrue:
				[anOop = (self fetchPointer: i ofObject: oop) ifTrue:
					[self interpreter printHex: oop; print: ' @ '; printNum: i; space; printOopShort: oop; cr.
					 i := 0]].
		 oop := self accessibleObjectAfter: oop]