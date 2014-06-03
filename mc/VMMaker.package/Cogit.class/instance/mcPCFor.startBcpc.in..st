method map
mcPCFor: bcpc startBcpc: startbcpc in: cogMethod
	"Answer the absolute machine code pc matching the zero-relative bytecode pc argument
	 in cogMethod, given the start of the bytecodes for cogMethod's block or method object."
	<var: #cogMethod type: #'CogBlockMethod *'>
	<returnTypeC: #usqInt>
	^self
		mapFor: cogMethod
		bcpc: startbcpc
		performUntil: #find:IsBackwardBranch:Mcpc:Bcpc:MatchingBcpc:
		arg: bcpc asVoidPointer