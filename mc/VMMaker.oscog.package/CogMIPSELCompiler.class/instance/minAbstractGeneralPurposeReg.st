accessing
minAbstractGeneralPurposeReg
	"Answer the smallest index of an abstract general-purpose register used by this compiler.
	 N.B.  Abstract registers are negative numbers."
	<inline: true>
	self flag: #bogus. "The caller should ask for a register mask, not a range."
	^TempReg