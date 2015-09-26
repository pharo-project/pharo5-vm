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
	numArgs = 0 ifTrue:
		[^self].
	numArgs > 1 ifTrue:
		[numArgs > 2 ifTrue:
			[numArgs > 3 ifTrue:
				[regOrConst3 < 0
					ifTrue: [cogit PushR: regOrConst3]
					ifFalse: [cogit PushCq: regOrConst3]].
			 regOrConst2 < 0
				ifTrue: [cogit PushR: regOrConst2]
				ifFalse: [cogit PushCq: regOrConst2]].
		regOrConst1 < 0
			ifTrue: [cogit PushR: regOrConst1]
			ifFalse: [cogit PushCq: regOrConst1]].
	regOrConst0 < 0
		ifTrue: [cogit PushR: regOrConst0]
		ifFalse: [cogit PushCq: regOrConst0]