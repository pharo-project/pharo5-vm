generate machine code
concretizeIDIVR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| regDivisor |
	regDivisor := operands at: 0.
	machineCode
		at: 0 put: 16rF7;
		at: 1 put: (self mod: ModReg RM: regDivisor RO: 7).
	^machineCodeSize := 2