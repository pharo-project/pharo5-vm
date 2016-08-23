debug printing
longPrintReferencesTo: anOop
	"Scan the heap long printing the oops of any and all objects that refer to anOop"
	| prntObj |
	<api>
	prntObj := false.
	self allObjectsDo:
		[:obj| | i |
		((self isPointersNonImm: obj) or: [self isCompiledMethod: obj]) ifTrue:
			[(self isCompiledMethod: obj)
				ifTrue:
					[i := (self literalCountOf: obj) + LiteralStart]
				ifFalse:
					[(self isContextNonImm: obj)
						ifTrue: [i := CtxtTempFrameStart + (coInterpreter fetchStackPointerOf: obj)]
						ifFalse: [i := self numSlotsOf: obj]].
			[(i := i - 1) >= 0] whileTrue:
				[anOop = (self fetchPointer: i ofObject: obj) ifTrue:
					[coInterpreter printHex: obj; print: ' @ '; printNum: i; cr.
					 prntObj := true.
					 i := 0]].
			prntObj ifTrue:
				[prntObj := false.
				 coInterpreter longPrintOop: obj]]]