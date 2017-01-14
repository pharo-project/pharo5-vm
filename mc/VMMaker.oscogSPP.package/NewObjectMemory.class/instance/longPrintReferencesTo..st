debug printing
longPrintReferencesTo: anOop
	"Scan the heap long printing the oops of any and all objects that refer to anOop"
	| oop i prntObj |
	<api>
	prntObj := false.
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
					[self printHex: oop; print: ' @ '; printNum: i; cr.
					 prntObj := true.
					 i := 0]].
			prntObj ifTrue:
				[prntObj := false.
				 coInterpreter longPrintOop: oop]].
		 oop := self accessibleObjectAfter: oop]