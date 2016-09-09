register allocation
availableFloatRegisterOrNoneFor: liveRegsMask
	"Answer an unused abstract register in the liveRegMask.
	 Subclasses with more registers can override to answer them."
	<returnTypeC: #sqInt>
	(liveRegsMask anyMask: (cogit registerMaskFor: DPFPReg0)) ifFalse:
		[^DPFPReg0].
	(liveRegsMask anyMask: (cogit registerMaskFor: DPFPReg1)) ifFalse:
		[^DPFPReg1].
	(liveRegsMask anyMask: (cogit registerMaskFor: DPFPReg2)) ifFalse:
		[^DPFPReg2].
	(liveRegsMask anyMask: (cogit registerMaskFor: DPFPReg3)) ifFalse:
		[^DPFPReg3].
	(liveRegsMask anyMask: (cogit registerMaskFor: DPFPReg4)) ifFalse:
		[^DPFPReg4].
	(liveRegsMask anyMask: (cogit registerMaskFor: DPFPReg5)) ifFalse:
		[^DPFPReg5].
	(liveRegsMask anyMask: (cogit registerMaskFor: DPFPReg6)) ifFalse:
		[^DPFPReg6].
	(liveRegsMask anyMask: (cogit registerMaskFor: DPFPReg7)) ifFalse:
		[^DPFPReg7].

	^ NoReg