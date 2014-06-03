trampolines
ceStoreCheck: anOop
	<api>
	"Do the store check.  Answer the argument for the benefit of the code generator;
	 ReceiverResultReg may be caller-saved and hence smashed by this call.  Answering
	 it allows the code generator to reload ReceiverResultReg cheaply."
	self assert: (self isNonImmediate: anOop).
	self assert: (self oop: anOop isGreaterThanOrEqualTo: oldSpaceStart).
	self assert: (self isRemembered: anOop) not.
	scavenger remember: anOop.
	self setIsRememberedOf: anOop to: true.
	^anOop