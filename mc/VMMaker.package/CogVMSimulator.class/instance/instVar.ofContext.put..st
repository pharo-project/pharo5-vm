frame access
instVar: index ofContext: aMarriedContext put: anOop
	"self shortPrintFrameAndCallers: localFP.
	Transcript print: byteCount; tab; print: thisContext; cr.
	self print: index; cr.
	self printContext: aMarriedContext.
	self shortPrintOop: anOop.
	(self confirm: 'continue?') ifFalse: [self halt]."
	"(self stringOf: (self penultimateLiteralOf: (self fetchPointer: MethodIndex ofObject: aMarriedContext))) = #indexOf:startingAt:ifAbsent: ifTrue:
		[self halt]."
	^super instVar: index ofContext: aMarriedContext put: anOop