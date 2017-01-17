register allocation
availableRegisterOrNoneFor: liveRegsMask
	"Answer an unused abstract register in the liveRegMask.
	 Subclasses with more registers can override to answer them.
	 N.B. Do /not/ allocate TempReg."
	<returnTypeC: #sqInt>
	(cogit register: Extra6Reg isInMask: liveRegsMask) ifFalse:
		[^Extra6Reg].
	^super availableRegisterOrNoneFor: liveRegsMask