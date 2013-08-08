debugging traps
instVar: offset ofContext: aOnceMarriedContext

	"offset = InstructionPointerIndex ifTrue:
		[Transcript nextPutAll: '==================='; cr.
		  self printContext: 16r1715630.
		 self printCallStackOf: aOnceMarriedContext currentFP: framePointer.
		 Transcript nextPutAll: '==================='; cr.
		 self halt]."

	| result |
	"self shortPrintFrameAndCallers: localFP.
	Transcript print: byteCount; tab; print: thisContext; cr.
	self print: offset; cr.
	self printContext: aOnceMarriedContext.
	(self confirm: 'continue?') ifFalse: [self halt]."
	result := super instVar: offset ofContext: aOnceMarriedContext.
	"offset = StackPointerIndex ifTrue:
		[Transcript nextPutAll: '^stackp ', (self integerValueOf: result) printString; tab.
		 self shortPrintContext: aOnceMarriedContext.
		 (#(24205456 24205732) includes: aOnceMarriedContext) ifTrue:
		 	[(self checkIsStillMarriedContext: aOnceMarriedContext currentFP: localFP)
				ifTrue: [self printFrame: (self frameOfMarriedContext: aOnceMarriedContext) WithSP: (self frameOfMarriedContext: aOnceMarriedContext) - 48]
				ifFalse: [self printContext: aOnceMarriedContext]]]."
	^result