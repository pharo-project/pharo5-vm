method map
mcPCForBackwardBranch: bcpc startBcpc: startbcpc in: cogMethod
	"Answer the absolute machine code pc matching the zero-relative
	 bytecode pc of a backward branch in cogMethod, given the start
	 of the bytecodes for cogMethod's block or method object."
	<api>
	<var: #cogMethod type: #'CogBlockMethod *'>
	<returnTypeC: #usqInt>
	^self
		mapFor: cogMethod
		bcpc: startbcpc
		performUntil: #findBackwardBranch:IsBackwardBranch:Mcpc:Bcpc:MatchingBcpc:
		arg: bcpc asVoidPointer