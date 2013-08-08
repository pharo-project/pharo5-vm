generate machine code
concretizeCPUID
	machineCode
		at: 0 put: 16r0F;
		at: 1 put: 16rA2.
	^machineCodeSize := 2