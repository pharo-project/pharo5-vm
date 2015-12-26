generate machine code
concretizeIDIVR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| regDivisor |
	regDivisor := operands at: 0.
	machineCode
		at: 0 put: (self rexR: 0 x: 0 b: regDivisor);
		at: 1 put: 16rF7;
		at: 2 put: (self mod: ModReg RM: regDivisor RO: 7).
	^machineCodeSize := 3