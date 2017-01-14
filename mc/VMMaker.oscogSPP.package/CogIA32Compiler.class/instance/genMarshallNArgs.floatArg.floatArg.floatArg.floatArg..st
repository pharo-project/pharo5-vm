abi
genMarshallNArgs: numArgs floatArg: regOrConst0 floatArg: regOrConst1 floatArg: regOrConst2 floatArg: regOrConst3
	"Generate the code to pass up to four arguments in a C run-time call.  Hack: each argument is
	 either a negative number, which encodes a constant, or a non-negative number, that of a register.

	 Run-time calls have no more than four arguments, so chosen so that on ARM, where in its C ABI the
	 first four integer arguments are passed in registers, all arguments can be passed in registers.  We
	 defer to the back end to generate this code not so much that the back end knows whether it uses
	 the stack or registers to pass arguments (it does, but...). In fact we defer for an extremely evil reason.
	 Doing so allows the x64 (where up to 6 args are passed) to assign the register arguments in an order
	 that allows some of the argument registers to be used for specific abstract  registers, specifically
	 ReceiverResultReg and ClassReg.  This is evil, evil, evil, but also it's really nice to keep using the old
	 register assignments the original author has grown accustomed to."
	<inline: true>
	numArgs = 0 ifTrue:
		[^self].
	numArgs > 1 ifTrue:
		[numArgs > 2 ifTrue:
			[numArgs > 3 ifTrue:
				[(cogit isTrampolineArgConstant: regOrConst3)
					ifFalse: [cogit PushRd: regOrConst3]
					ifTrue: [cogit PushC64: (cogit trampolineArgValue: regOrConst3)]].
			 (cogit isTrampolineArgConstant: regOrConst2)
				ifFalse: [cogit PushRd: regOrConst2]
				ifTrue: [cogit PushC64: (cogit trampolineArgValue: regOrConst2)]].
		(cogit isTrampolineArgConstant: regOrConst1)
			ifFalse: [cogit PushRd: regOrConst1]
			ifTrue: [cogit PushC64: (cogit trampolineArgValue: regOrConst1)]].
	(cogit isTrampolineArgConstant: regOrConst0)
		ifFalse: [cogit PushRd: regOrConst0]
		ifTrue: [cogit PushC64: (cogit trampolineArgValue: regOrConst0)]