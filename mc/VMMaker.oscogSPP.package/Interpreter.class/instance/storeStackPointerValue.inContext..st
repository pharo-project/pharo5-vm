contexts
storeStackPointerValue: value inContext: contextPointer
	"Assume: value is an integerValue"

	self storePointerUnchecked: StackPointerIndex ofObject: contextPointer
		withValue: (self integerObjectOf: value).