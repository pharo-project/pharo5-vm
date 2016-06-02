abi
genMarshallNArgs: numArgs arg: regOrConst0 arg: regOrConst1 arg: regOrConst2 arg: regOrConst3
	"Generate the code to pass up to four arguments in a C run-time call.  Hack: each argument is
	 either a negative number, which encodes a constant, or a non-negative number, that of a register.

	 Run-time calls have no more than four arguments, so chosen so that on ARM, where in its C ABI the
	 first four integer arguments are passed in registers, all arguments can be passed in registers.  We
	 defer to the back end to generate this code not so much that the back end knows whether it uses
	 the stack or registers to pass arguments (it does, but...). In fact we defer for an extremely evil reason.
	 Doing so allows the x64 (where up to 6 args are passed) to assign the register arguments in an order
	 that allows some of the argument registers to be used for specific abstract  registers, specifically
	 ReceiverResultReg and ClassReg.  This is evil, evil, evil, but also it's really nice to keep using the old
	 register assignments the original author has grown accustomed to.

	 How can this possibly work?  Look at Cogit class>>runtime for a list of the run-time calls and their
	 arguments, including which arguments are passed in which registers.  Look at CogX64Compiler's
	 subclass implementations of initializeAbstractRegisters.  There are no calls in which ReceiverResultReg
	 (RDX) and/or ClassReg (RCX) are passed along with Arg0Reg and Arg1Reg, and none in which the use of
	 either ReceiverResultReg or ClassReg conflict for args 3 & 4.  So if args are assigned in order, the
	 registers do not get overwritten.  Yes, this is evil, but it's so nice to continue to use RCX & RDX.

	 Argument registers for args 0 to 3 in SysV are RDI RSI RDX RCX, and in Win64 are RDI RSI R8 R9"
	<inline: true>
	numArgs = 0 ifTrue: [^self].
	(cogit isTrampolineArgConstant: regOrConst0)
		ifTrue: [cogit MoveCq: (cogit trampolineArgValue: regOrConst0) R: RDI] "a.k.a. Arg0Reg"
		ifFalse:
			[regOrConst0 ~= RDI ifTrue:
				[cogit MoveR: regOrConst0 R: RDI]].
	numArgs = 1 ifTrue: [^self].
	(cogit isTrampolineArgConstant: regOrConst1)
		ifTrue: [cogit MoveCq: (cogit trampolineArgValue: regOrConst1) R: RSI] "a.k.a. Arg1Reg"
		ifFalse:
			[regOrConst1 ~= RSI ifTrue:
				[cogit MoveR: regOrConst1 R: RSI]].
	numArgs = 2 ifTrue: [^self].
	self cppIf: ABI == #SysV ifTrue:
		[(cogit isTrampolineArgConstant: regOrConst2)
			ifTrue: [cogit MoveCq: (cogit trampolineArgValue: regOrConst2) R: RDX] "a.k.a. ReceiverResultReg"
			ifFalse:
				[regOrConst2 ~= RDX ifTrue:
					[cogit MoveR: regOrConst2 R: RDX]].
		 numArgs = 3 ifTrue: [^self].
		 (cogit isTrampolineArgConstant: regOrConst3)
				ifTrue: [cogit MoveCq: (cogit trampolineArgValue: regOrConst3) R: RCX] "a.k.a. ClassReg"
				ifFalse:
					[regOrConst3 ~= RCX ifTrue:
						[cogit MoveR: regOrConst3 R: RCX]]].
	self cppIf: ABI == #MSVC ifTrue: "completely untested..."
		[(cogit isTrampolineArgConstant: regOrConst2)
			ifTrue: [cogit MoveCq: (cogit trampolineArgValue: regOrConst2) R: R8] "a.k.a. RISCTempReg in CogInLineLiteralsX64Compiler and Extra6Reg in CogOutOfLineLiteralsX64Compiler"
			ifFalse:
				[regOrConst2 ~= R8 ifTrue:
					[cogit MoveR: regOrConst2 R: R8]].
		 numArgs = 3 ifTrue: [^self].
		 (cogit isTrampolineArgConstant: regOrConst3)
				ifTrue: [cogit MoveCq: (cogit trampolineArgValue: regOrConst3) R: R9] "a.k.a. SendNumArgsReg"
				ifFalse:
					[regOrConst3 ~= R9 ifTrue:
						[cogit MoveR: regOrConst3 R: R9]]].
	self assert: numArgs <= 4