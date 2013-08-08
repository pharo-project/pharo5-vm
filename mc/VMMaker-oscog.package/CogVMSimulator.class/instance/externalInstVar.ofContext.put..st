frame access
externalInstVar: index ofContext: maybeMarriedContext put: anOop
	"self shortPrintFrameAndCallers: framePointer.
	Transcript print: byteCount; tab; print: thisContext; cr.
	self print: index; cr.
	self printContext: maybeMarriedContext.
	self shortPrintOop: anOop.
	(self confirm: 'continue?') ifFalse: [self halt]."
	^super externalInstVar: index ofContext: maybeMarriedContext put: anOop