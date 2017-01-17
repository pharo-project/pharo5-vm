generate machine code
concretizeMOVSQ
	<inline: true>
	machineCode
		at: 0 put: (self rexw: true r: 0 x: 0 b: 0);
		at: 1 put: 16rA5.
	^machineCodeSize := 2