trampolines
ceStoreCheck: anOop
	<api>
	"Do the store check.  Answer the argument for the benefit of the code generator;
	ReceiverResultReg may be caller-saved and hence smashed by this call.  Answering
	it allows the code generator to reload ReceiverResultReg cheaply."
	self assert: (self isNonIntegerObject: anOop).
	self assert: (self oop: anOop isLessThan: self youngStart).
	self assert: (self isYoungRoot: anOop) not.
	self noteAsRoot: anOop headerLoc: anOop.
	^anOop