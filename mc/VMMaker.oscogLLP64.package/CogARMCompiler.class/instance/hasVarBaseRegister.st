testing
hasVarBaseRegister
	"Answer if the processor has a dedicated callee-saved register to point to
	 the base of commonly-accessed variables. On ARM we use R10 for this."
	^true "r10/sl"