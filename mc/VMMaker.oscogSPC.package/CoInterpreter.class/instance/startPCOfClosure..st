compiled methods
startPCOfClosure: aBlockClosure
	"Zero-relative version of BlockClosure>>startpc."
	^(objectMemory integerValueOf: (objectMemory fetchPointer: ClosureStartPCIndex ofObject: aBlockClosure)) - 1