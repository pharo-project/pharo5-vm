method map
bytecodePCFor: mcpc startBcpc: startbcpc in: cogMethod
	"Answer the zero-relative bytecode pc matching the machine code pc argument in
	 cogMethod, given the start of the bytecodes for cogMethod's block or method object."
	<api>
	<var: #cogMethod type: #'CogBlockMethod *'>
	^self
		mapFor: cogMethod
		bcpc: startbcpc
		performUntil: #find:IsBackwardBranch:Mcpc:Bcpc:MatchingMcpc:
		arg: mcpc asVoidPointer