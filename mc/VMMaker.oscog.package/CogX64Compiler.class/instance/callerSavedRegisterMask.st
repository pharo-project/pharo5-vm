accessing
callerSavedRegisterMask
	"See e.g. Figure 3.4 Register Usage in
		System V Application Binary Interface
		AMD64 Architecture Processor Supplement
	 N.B.  We are playing fast and loose here being processor-specific.
	 Soon enough this needs to be OS-specific."
	^cogit
		registerMaskFor: (self abstractRegisterForConcreteRegister: RAX)
		and: (self abstractRegisterForConcreteRegister: RCX)
		and: (self abstractRegisterForConcreteRegister: RDX)
		and: (self abstractRegisterForConcreteRegister: RSI)
		and: (self abstractRegisterForConcreteRegister: RDI)
		and: (self abstractRegisterForConcreteRegister: R8)
		and: (self abstractRegisterForConcreteRegister: R9)
		and: (self abstractRegisterForConcreteRegister: R10)
		and: (self abstractRegisterForConcreteRegister: R11)