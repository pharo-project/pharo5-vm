accessing-abstract
setFramePointer: framePointer stackPointer: stackPointer
	"Initialize the processor's frame and stack pointers"
	self fp: framePointer.
	self sp: stackPointer