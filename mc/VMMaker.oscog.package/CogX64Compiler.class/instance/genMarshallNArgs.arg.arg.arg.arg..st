abi
genMarshallNArgs: numArgs arg: regOrConst0 arg: regOrConst1 arg: regOrConst2 arg: regOrConst3
	"Generate the code to pass up to four arguments in a C run-time call.  Hack: each argument is either a
	 negative number, that of an abstract register, or a non-negative number, that of a constant parameter.

	 Run-time calls have no more than four arguments, so chosen so that on ARM, where in its C ABI the
	 first four integer arguments are passed in registers, all arguments can be passed in registers.  We
	 defer to the back end to generate this code not so much that teh back end knows whether it uses
	 the stack or registers to pass arguments (it does, but...). In fact we defer for an extremely evil reason.
	 Doing so allows the x64 (where up to 6 args are passed) to assign the register arguments in an order
	 that allows some of the argument registers to be used for specificabstract  registers, specifically
	 ReceiverResultReg and ClassReg.  This is evil, evil, evil, but also its really nice to keep using the old
	 register assignments the principal author has grown accustomed to.

	 How can this possibly work?  Look at Cogit class>>runtime for a list of the run-time calls and their
	 arguments, including which arguments are passed in which registers.  Look at CogX64Compiler's
	 subclass implementations of concreteRegister:.  There are no calls in which ReceiverResultReg (RDX)
	 and/or ClassReg (RCX) are passed along with Arg0Reg and Arg1Reg, and none in which the use of
	 either ReceiverResultReg or ClassReg conflict for args 3 & 4.  So if args are assigned in order, the
	 registers do not get overwritten.  Yes, this is evil, but it's so nice to continue to use RCX & RDX."
	<inline: true>
	numArgs = 0 ifTrue: [^self].
	regOrConst0 < 0
		ifTrue: [cogit MoveCq: regOrConst0 R: RDI]
		ifFalse: [cogit MoveR: regOrConst0 R: RDI].
	numArgs = 1 ifTrue: [^self].
	regOrConst1 < 0
		ifTrue: [cogit MoveCq: regOrConst1 R: RSI]
		ifFalse: [cogit MoveR: regOrConst1 R: RSI].
	numArgs = 2 ifTrue: [^self].
	regOrConst2 < 0
		ifTrue: [cogit MoveCq: regOrConst2 R: RDX]
		ifFalse: [cogit MoveR: regOrConst2 R: RDX].
	numArgs = 3 ifTrue: [^self].
	regOrConst3 < 0
		ifTrue: [cogit MoveCq: regOrConst3 R: RCX]
		ifFalse: [cogit MoveR: regOrConst3 R: RCX]