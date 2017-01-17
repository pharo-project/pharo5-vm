frame access
externalInstVar: index ofContext: aMarriedContext put: anOop
	| imMarried shesMarried result |
	index == SenderIndex ifTrue:
		[imMarried := self checkIsStillMarriedContext: aMarriedContext currentFP: localFP.
		(objectMemory isContext: anOop) ifTrue:
			[shesMarried := self checkIsStillMarriedContext: anOop currentFP: localFP.
			 "self shortPrintContext: aMarriedContext.
			  self shortPrintContext: anOop"]].
	result := super externalInstVar: index ofContext: aMarriedContext put: anOop.
	imMarried ifNotNil:
		[self assert: imMarried == (self checkIsStillMarriedContext: aMarriedContext currentFP: nil).
		 shesMarried ifNotNil:
			[self assert: shesMarried == (self checkIsStillMarriedContext: anOop currentFP: nil)]].
	^result