frame access
externalInstVar: index ofContext: aContext put: anOop
	"self shortPrintFrameAndCallers: framePointer.
	Transcript print: byteCount; tab; print: thisContext; cr.
	self print: index; cr.
	self printContext: aContext.
	self shortPrintOop: anOop.
	(self confirm: 'continue?') ifFalse: [self halt]."
	"(self stringOf: (self penultimateLiteralOf: (self fetchPointer: MethodIndex ofObject: aContext))) = #indexOf:startingAt:ifAbsent: ifTrue:
		[self halt]."
	^super externalInstVar: index ofContext: aContext put: anOop