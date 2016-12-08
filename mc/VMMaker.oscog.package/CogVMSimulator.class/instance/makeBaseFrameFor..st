frame access
makeBaseFrameFor: aContext "<Integer>"
	"aContext =  26431360 ifTrue: [self halt]."
	"(objectMemory fetchPointer: MethodIndex ofObject: aContext) = 16rD4C178 ifTrue:
		[self halt]."
	^super makeBaseFrameFor: aContext