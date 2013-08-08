frame access
instVar: index ofContext: aMarriedContext put: anOop
	"self shortPrintFrameAndCallers: localFP.
	Transcript print: byteCount; tab; print: thisContext; cr.
	self print: index; cr.
	self printContext: aMarriedContext.
	self shortPrintOop: anOop.
	(self confirm: 'continue?') ifFalse: [self halt]."
	^super instVar: index ofContext: aMarriedContext put: anOop