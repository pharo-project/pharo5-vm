debugging traps
pushMaybeContextReceiverVariable: index
	"(index = SenderIndex or: [index = ClosureIndex]) ifTrue: [self halt]."
	^super pushMaybeContextReceiverVariable: index