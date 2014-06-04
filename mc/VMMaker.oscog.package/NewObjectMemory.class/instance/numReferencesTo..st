debug printing
numReferencesTo: anOop
	"Answer the number of objects that refer to anOop, other than anOop."
	| oop i n |
	oop := self firstAccessibleObject.
	n := 0.
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
					[anOop ~= oop ifTrue:
						[n := n + 1].
					 i := 0]]].
		 oop := self accessibleObjectAfter: oop].
	^n