generate machine code
concretizeIDIVR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| regDivisor |
	regDivisor := self concreteRegister: (operands at: 0).
	machineCode
		at: 0 put: (self rexR: regDivisor x: 0 b: 0);
		at: 1 put: 16rF7;
		at: 2 put: (self mod: ModReg RM: regDivisor RO: 7).
	^machineCodeSize := 3