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
	 register assignments the principal author has grown accustomed to."
	<inline: true>
	numArgs = 0 ifTrue: [^self].
	regOrConst0 >= 0
		ifTrue: [cogit MoveCq: regOrConst0 R: CArg0Reg]
		ifFalse: [cogit MoveR: regOrConst0 R: CArg0Reg].
	numArgs = 1 ifTrue: [^self].
	regOrConst1 >= 0
		ifTrue: [cogit MoveCq: regOrConst1 R: CArg1Reg]
		ifFalse: [cogit MoveR: regOrConst1 R: CArg1Reg].
	numArgs = 2 ifTrue: [^self].
	regOrConst2 >= 0
		ifTrue: [cogit MoveCq: regOrConst2 R: CArg2Reg]
		ifFalse: [cogit MoveR: regOrConst2 R: CArg2Reg].
	numArgs = 3 ifTrue: [^self].
	regOrConst3 >= 0
		ifTrue: [cogit MoveCq: regOrConst3 R: CArg3Reg]
		ifFalse: [cogit MoveR: regOrConst3 R: CArg3Reg]