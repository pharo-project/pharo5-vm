register allocation
availableRegisterOrNoneFor: liveRegsMask
	"Answer an unused abstract register in the liveRegMask.
	 Subclasses with more registers can override to answer them.
	 N.B. Do /not/ allocate TempReg."
	<returnTypeC: #sqInt>
	(cogit register: Arg1Reg isInMask: liveRegsMask) ifFalse:
		[^Arg1Reg].
	(cogit register: Arg0Reg isInMask: liveRegsMask) ifFalse:
		[^Arg0Reg].
	(cogit register: SendNumArgsReg isInMask: liveRegsMask) ifFalse:
		[^SendNumArgsReg].
	(cogit register: ClassReg isInMask: liveRegsMask) ifFalse:
		[^ClassReg].
	(cogit register: ReceiverResultReg isInMask: liveRegsMask) ifFalse:
		[^ReceiverResultReg].
	^NoReg