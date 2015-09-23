accessing
minAbstractGeneralPurposeReg
	"Answer the smallest index of an abstract general-purpose register used by this compiler.
	 N.B.  Abstract registers are negative numbers."
	<inline: true>
	^self subclassResponsibility