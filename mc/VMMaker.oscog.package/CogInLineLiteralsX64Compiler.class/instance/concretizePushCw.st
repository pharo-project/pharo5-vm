generate machine code
concretizePushCw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| value offset |
	value := operands at: 0.
	(self isAnInstruction: (cogit cCoerceSimple: value to: #'AbstractInstruction *')) ifTrue:
		[value := (cogit cCoerceSimple: value to: #'AbstractInstruction *') address].
	(cogit addressIsInCurrentCompilation: value) ifTrue:
		[offset := value - (address + 6).
		 machineCode
			at: 0 put: 16rFF;
			at: 1 put: 16r35;
			at: 2 put: (offset bitAnd: 16rFF);
			at: 3 put: (offset >> 8 bitAnd: 16rFF);
			at: 4 put: (offset >> 16 bitAnd: 16rFF);
			at: 5 put: (offset >> 24 bitAnd: 16rFF).
		^machineCodeSize := 6].
	machineCode
		at:  0 put: (self rexR: ConcreteRISCTempReg x: 0 b: ConcreteRISCTempReg);
		at:  1 put: 16rB8 + (ConcreteRISCTempReg bitAnd: 7);
		at:  2 put: (value bitAnd: 16rFF);
		at:  3 put: (value >> 8 bitAnd: 16rFF);
		at:  4 put: (value >> 16 bitAnd: 16rFF);
		at:  5 put: (value >> 24 bitAnd: 16rFF);
		at:  6 put: (value >> 32 bitAnd: 16rFF);
		at:  7 put: (value >> 40 bitAnd: 16rFF);
		at:  8 put: (value >> 48 bitAnd: 16rFF);
		at:  9 put: (value >> 56 bitAnd: 16rFF);
		at: 10 put: 16r41;
		at: 11 put: 16r50 + (ConcreteRISCTempReg - 8). "The 50 will disambiguate between MoveCwR, PushCwR and ArithCwR, which ends with a (self mod: ModReg RM: 0 RO: 0)"
		self assert: ConcreteRISCTempReg >= 8.
	self assert: (self mod: ModReg RM: 0 RO: 0) > 16r57.
	^machineCodeSize := 12