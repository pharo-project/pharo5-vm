verification
unimplementedOpcodes
	"Check computeMaximumSize and dispatchConcretize for unimplemented opcodes."
	"self subclasses collect: [:compiler| {compiler. compiler unimplementedOpcodes}]"
	| opcodes cmsLiterals dcLiterals |
	opcodes := CogRTLOpcodes opcodes, self specificOpcodes.
	cmsLiterals := (self >> #computeMaximumSize) literals
						select: [:l| l isVariableBinding]
						thenCollect: [:l| l key].
	dcLiterals := (self >> #dispatchConcretize) literals
						select: [:l| l isVariableBinding]
						thenCollect: [:l| l key].
	^Dictionary new
		at: #computeMaximumSize put: (opcodes reject: [:opcode| cmsLiterals includes: opcode]);
		at: #dispatchConcretize put: (opcodes reject: [:opcode| dcLiterals includes: opcode]);
		yourself