debugging traps
primitiveContextAtPut
	"| aContext |
	aContext := self stackValue: 2.
	(#(24205456 24205732) includes: aContext) ifTrue:
		[(self checkIsStillMarriedContext: aContext currentFP: framePointer)
			ifTrue: [self printFrame: (self frameOfMarriedContext: aContext)
						WithSP: (self frameOfMarriedContext: aContext) - 48]
			ifFalse: [self printContext: aContext]]."
	^super primitiveContextAtPut