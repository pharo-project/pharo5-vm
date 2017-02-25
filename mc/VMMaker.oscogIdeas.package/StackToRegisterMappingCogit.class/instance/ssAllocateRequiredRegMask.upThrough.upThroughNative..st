simulation stack
ssAllocateRequiredRegMask: requiredRegsMask upThrough: stackPtr upThroughNative: nativeStackPtr
	| lastRequired lastRequiredNative liveRegs |
	lastRequired := -1.
	lastRequiredNative := -1.
	"compute live regs while noting the last occurrence of required regs.
	 If these are not free we must spill from simSpillBase to last occurrence.
	 Note we are conservative here; we could allocate FPReg in frameless methods."
	liveRegs := self registerMaskFor: FPReg and: SPReg.
	(simSpillBase max: 0) to: stackPtr do:
		[:i|
		liveRegs := liveRegs bitOr: (self simStackAt: i) registerMask.
		((self simStackAt: i) registerMask bitAnd: requiredRegsMask) ~= 0 ifTrue:
			[lastRequired := i]].
	LowcodeVM ifTrue:
		[(simNativeSpillBase max: 0) to: nativeStackPtr do:
			[:i|
			liveRegs := liveRegs bitOr: (self simNativeStackAt: i) nativeRegisterMask.
			((self simNativeStackAt: i) nativeRegisterMask anyMask: requiredRegsMask) ifTrue:
				[lastRequiredNative := i]]].
	"If any of requiredRegsMask are live we must spill."
	(liveRegs anyMask: requiredRegsMask) ifTrue:
		[self ssFlushTo: lastRequired nativeFlushTo: lastRequiredNative.
		self assert: (self liveRegisters bitAnd: requiredRegsMask) = 0]