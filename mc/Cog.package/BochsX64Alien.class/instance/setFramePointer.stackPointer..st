accessing-abstract
setFramePointer: framePointer stackPointer: stackPointer
	"Initialize the processor's frame and stack pointers"
	self rbp: framePointer.
	self rsp: stackPointer