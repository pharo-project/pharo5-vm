abi
genMarshallNArgs: numArgs floatArg: regOrConst0 floatArg: regOrConst1 floatArg: regOrConst2 floatArg: regOrConst3
	"Generate the code to pass up to four float arguments in a C run-time call.  Hack: each argument is
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
	SysV ifFalse: "WIN64 ABI allways reserve shadow space on the stack for callee to save up to 4 register parameters"
		[cogit SubCq: 32 R: RSP].
	numArgs = 0 ifTrue: [^self].
	
	(cogit isTrampolineArgConstant: regOrConst0)
		ifTrue: [cogit MoveCf64: (cogit trampolineArgValue: regOrConst0) Rd: XMM0L] "a.k.a. DPFPReg0"
		ifFalse: [regOrConst0 ~= XMM0L ifTrue:
						[cogit MoveR: regOrConst0 R: XMM0L]].
	numArgs = 1 ifTrue: [^self].
	
	(cogit isTrampolineArgConstant: regOrConst1)
		ifTrue: [cogit MoveCf64: (cogit trampolineArgValue: regOrConst1) Rd: XMM1L] "a.k.a. DPFPReg1"
		ifFalse: [regOrConst1 ~= XMM1L ifTrue:
						[cogit MoveR: regOrConst1 R: XMM1L]].
	numArgs = 2 ifTrue: [^self].

	(cogit isTrampolineArgConstant: regOrConst2)
		ifTrue: [cogit MoveCf64: (cogit trampolineArgValue: regOrConst2) Rd: XMM2L] "a.k.a. DPFPReg0"
		ifFalse: [regOrConst2 ~= XMM2L ifTrue:
						[cogit MoveR: regOrConst2 R: XMM2L]].
	numArgs = 3 ifTrue: [^self].

	(cogit isTrampolineArgConstant: regOrConst3)
		ifTrue: [cogit MoveCf64: (cogit trampolineArgValue: regOrConst3) Rd: XMM3L] "a.k.a. DPFPReg3"
		ifFalse: [regOrConst3 ~= XMM3L ifTrue:
						[cogit MoveR: regOrConst3 R: XMM3L]].

	self assert: numArgs <= 4