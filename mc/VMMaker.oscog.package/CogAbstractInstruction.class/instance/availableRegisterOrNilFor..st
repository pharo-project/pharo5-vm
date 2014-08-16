register allocation
availableRegisterOrNilFor: liveRegsMask
	"Answer an unused abstract register in the liveRegMask.
	 Subclasses with more registers can override to answer them."
	<returnTypeC: #sqInt>
	(liveRegsMask anyMask: (cogit registerMaskFor: Arg1Reg)) ifFalse:
		[^Arg1Reg].
	(liveRegsMask anyMask: (cogit registerMaskFor: Arg0Reg)) ifFalse:
		[^Arg0Reg].
	(liveRegsMask anyMask: (cogit registerMaskFor: SendNumArgsReg)) ifFalse:
		[^SendNumArgsReg].
	(liveRegsMask anyMask: (cogit registerMaskFor: ClassReg)) ifFalse:
		[^ClassReg].
	(liveRegsMask anyMask: (cogit registerMaskFor: ReceiverResultReg)) ifFalse:
		[^ReceiverResultReg].
	^nil