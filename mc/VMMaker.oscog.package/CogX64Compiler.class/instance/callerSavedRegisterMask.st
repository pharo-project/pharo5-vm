accessing
callerSavedRegisterMask
	"See e.g. Figure 3.4 Register Usage in
		System V Application Binary Interface
		AMD64 Architecture Processor Supplement
	 N.B.  We are playing fast and loose here being processor-specific.
	 Soon enough this needs to be OS-specific."
	^cogit
		registerMaskFor: RAX
		and: RCX
		and: RDX
		and: RSI
		and: RDI
		and: R8
		and: R9
		and: R10
		and: R11