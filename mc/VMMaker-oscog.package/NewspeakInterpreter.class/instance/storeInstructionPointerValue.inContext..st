contexts
storeInstructionPointerValue: value inContext: contextPointer
	"Assume: value is an integerValue"

	self storePointerUnchecked: InstructionPointerIndex ofObject: contextPointer withValue: (self integerObjectOf: value).