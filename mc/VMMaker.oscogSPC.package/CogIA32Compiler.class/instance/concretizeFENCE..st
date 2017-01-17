generate machine code
concretizeFENCE: regOpcode
	<inline: true>
	machineCode
		at: 0 put: 16r0F;
		at: 1 put: 16rAE;
		at: 2 put: (self mod: ModReg RM: 0 RO: regOpcode).
	^machineCodeSize := 3