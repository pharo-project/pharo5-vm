simulation stack
ssAllocateRequiredRegMask: requiredRegsMask upThrough: stackPtr
	| lastRequired liveRegs |
	lastRequired := -1.
	"compute live regs while noting the last occurrence of required regs.
	 If these are not free we must spill from simSpillBase to last occurrence.
	 Note we are conservative here; we could allocate FPReg in frameless methods."
	liveRegs := self registerMaskFor: FPReg and: SPReg.
	(simSpillBase max: 0) to: stackPtr do:
		[:i|
		liveRegs := liveRegs bitOr: (self simStackAt: i) registerMask.
		((self simStackAt: i) registerMask bitAnd: requiredRegsMask) ~= 0 ifTrue:
			[lastRequired := i]].
	"If any of requiredRegsMask are live we must spill."
	(liveRegs bitAnd: requiredRegsMask) = 0 ifFalse:
		["Some live, must spill"
		self ssFlushTo: lastRequired.
		self assert: (self liveRegisters bitAnd: requiredRegsMask) = 0]