trampolines
ceBaseFrameReturn: returnValue
	"self printCallStackOf: (stackPages longAt: stackPage baseAddress) currentFP: stackPage baseFP.
	Transcript print: byteCount; tab; print: thisContext; cr.
	(self confirm: 'continue?') ifFalse: [self returnValue hex]."
	"returnValue = 16r01934F78 ifTrue: [self halt]."
	^super ceBaseFrameReturn: returnValue