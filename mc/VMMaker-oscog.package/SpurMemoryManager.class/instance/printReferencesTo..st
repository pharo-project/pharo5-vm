debug printing
printReferencesTo: anOop
	"Scan the heap printing the oops of any and all objects that refer to anOop"
	<api>
	self allObjectsDo:
		[:obj| | i |
		((self isPointersNonImm: obj) or: [self isCompiledMethod: obj])
			ifTrue:
				[(self isCompiledMethod: obj)
					ifTrue:
						[i := (coInterpreter literalCountOf: obj) + LiteralStart]
					ifFalse:
						[(self isContextNonImm: obj)
							ifTrue: [i := CtxtTempFrameStart + (coInterpreter fetchStackPointerOf: obj)]
							ifFalse: [i := self lengthOf: obj]].
				[(i := i - 1) >= 0] whileTrue:
					[anOop = (self fetchPointer: i ofObject: obj) ifTrue:
						[coInterpreter printHex: obj; print: ' @ '; printNum: i; space; printOopShort: obj; cr.
						 i := 0]]]
			ifFalse:
				[((self isForwarded: obj)
				 and: [(self fetchPointer: 0 ofMaybeForwardedObject: obj) = anOop]) ifTrue:
					[coInterpreter printHex: obj; print: ' => '; printHex: anOop; cr]]]