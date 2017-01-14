frame access
instVar: index ofContext: aMarriedContext put: anOop
	| imMarried shesMarried result |
	index == SenderIndex ifTrue:
		[imMarried := self checkIsStillMarriedContext: aMarriedContext currentFP: localFP.
		(objectMemory isContext: anOop) ifTrue:
			[shesMarried := self checkIsStillMarriedContext: anOop currentFP: localFP.
			"self cr.
			self shortPrintContext: aMarriedContext.
			self shortPrintContext: anOop.
			(#('yield:' 'nextPut:') includesAnyOf: {self stringOf: (self selectorOfContext: aMarriedContext). self stringOf: (self selectorOfContext: anOop)}) ifTrue:
				[self halt]"]].
	result := super instVar: index ofContext: aMarriedContext put: anOop.
	imMarried ifNotNil:
		[self assert: imMarried == (self checkIsStillMarriedContext: aMarriedContext currentFP: nil).
		 shesMarried ifNotNil:
			[self assert: shesMarried == (self checkIsStillMarriedContext: anOop currentFP: nil)]].
	^result