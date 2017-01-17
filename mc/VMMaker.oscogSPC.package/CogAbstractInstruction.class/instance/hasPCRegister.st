testing
hasPCRegister
	"Answer if the processor has a generally addressable pc register, such as the ARM.
	 On such processors we can execute jumping to pop top of stack by popping into
	 the pc register.  Note that this is not a generic RISC feature.  The PowerPC does not
	 allow one to pop into the pc for example.  So by default, answer false."
	^false