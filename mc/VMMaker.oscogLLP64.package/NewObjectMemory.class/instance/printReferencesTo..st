debug printing
printReferencesTo: anOop
	"Scan the heap printing the oops of any and all objects that refer to anOop"
	| oop i |
	<api>
	oop := self firstAccessibleObject.
	[oop = nil] whileFalse:
		[((self isPointersNonImm: oop) or: [self isCompiledMethod: oop]) ifTrue:
			[(self isCompiledMethod: oop)
				ifTrue:
					[i := (self literalCountOf: oop) + LiteralStart]
				ifFalse:
					[(self isContextNonImm: oop)
						ifTrue: [i := CtxtTempFrameStart + (coInterpreter fetchStackPointerOf: oop)]
						ifFalse: [i := self lengthOf: oop]].
			[(i := i - 1) >= 0] whileTrue:
				[anOop = (self fetchPointer: i ofObject: oop) ifTrue:
					[coInterpreter printHex: oop; print: ' @ '; printNum: i; space; printOopShort: oop; cr.
					 i := 0]]].
		 oop := self accessibleObjectAfter: oop]