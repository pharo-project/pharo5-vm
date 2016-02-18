register allocation
availableRegisterOrNoneFor: liveRegsMask
	"Answer an unused abstract register in the liveRegMask.
	 Subclasses with more registers can override to answer them."
	<returnTypeC: #sqInt>
	self flag: 'searching physical registers that are not assigned to abstract registers first will do a better job and allocate with fewer conflicts.  But this will be much easier if we use the same range for concrete and abstract registers (0-N) and simply number abstract registers the same as their corresponding concrete registers.'.
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