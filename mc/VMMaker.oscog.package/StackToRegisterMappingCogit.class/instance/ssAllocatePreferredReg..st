simulation stack
ssAllocatePreferredReg: preferredReg
	| preferredMask lastPreferred liveRegs |
	lastPreferred := -1.
	"compute live regs while noting the last occurrence of preferredReg.
	 If there are none free we must spill from simSpillBase to last occurrence."
	preferredMask := (self registerMaskFor: preferredReg).
	liveRegs := self registerMaskFor: TempReg and: FPReg and: SPReg.
	(simSpillBase max: 0) to: simStackPtr do:
		[:i|
		liveRegs := liveRegs bitOr: (self simStackAt: i) registerMask.
		(liveRegs bitAnd: preferredMask) ~= 0 ifTrue:
			[lastPreferred := i]].
	"If preferredReg is not live we can allocate it."
	(self register: preferredReg isInMask: liveRegs) ifFalse:
		[^preferredReg].
	"If any other is not live we can allocate it."
	GPRegMin to: GPRegMax do:
		[:reg|
		(self register: reg isInMask: liveRegs) ifFalse:
			[^reg]].
	"All live, must spill"
	self ssFlushTo: lastPreferred.
	self assert: (self liveRegisters bitAnd: preferredMask) = 0.
	^preferredReg