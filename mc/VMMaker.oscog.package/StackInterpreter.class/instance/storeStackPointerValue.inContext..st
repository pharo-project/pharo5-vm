internal interpreter access
storeStackPointerValue: value inContext: aContext
	"Assume: value is an integerValue"
	self assert: ReceiverIndex + value < (objectMemory lengthOf: aContext).
	objectMemory storePointerUnchecked: StackPointerIndex
		ofObject: aContext
		withValue: (objectMemory integerObjectOf: value)