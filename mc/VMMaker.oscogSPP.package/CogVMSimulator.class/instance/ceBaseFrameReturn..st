trampolines
ceBaseFrameReturn: returnValue
	"self printCallStackOf: (stackPages longAt: stackPage baseAddress) currentFP: stackPage baseFP.
	Transcript print: byteCount; tab; print: thisContext; cr.
	(self confirm: 'continue?') ifFalse: [self returnValue hex]."
	"returnValue = 16r01934F78 ifTrue: [self halt]."
	"| contextToReturnTo |
	contextToReturnTo := stackPages longAt: stackPage baseAddress.
	(self stringOf: (self penultimateLiteralOf: (self fetchPointer: MethodIndex ofObject: contextToReturnTo))) = #indexOf:startingAt:ifAbsent: ifTrue:
		[self halt]."
	^super ceBaseFrameReturn: returnValue