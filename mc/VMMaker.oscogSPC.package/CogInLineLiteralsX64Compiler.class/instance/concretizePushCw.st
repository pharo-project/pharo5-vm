generate machine code
concretizePushCw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| value offset |
	value := operands at: 0.
	(self isAnInstruction: (cogit cCoerceSimple: value to: #'AbstractInstruction *')) ifTrue:
		[value := (cogit cCoerceSimple: value to: #'AbstractInstruction *') address].
	(cogit addressIsInCurrentCompilation: value) ifTrue:
		[offset := value - (address + 7).
		 machineCode
			at: 0 put: (self rexR: RISCTempReg x: 0 b: 0);
			at: 1 put: 16r8D; "LoadEffectiveAddress"
			at: 2 put: (self mod: ModRegInd RM: 5 RO: RISCTempReg);
			at: 3 put: (offset bitAnd: 16rFF);
			at: 4 put: (offset >> 8 bitAnd: 16rFF);
			at: 5 put: (offset >> 16 bitAnd: 16rFF);
			at: 6 put: (offset >> 24 bitAnd: 16rFF);
			at: 7 put: 16r41;
			at: 8 put: 16r48 + RISCTempReg.
		^machineCodeSize := 9].
	machineCode
		at:  0 put: (self rexR: RISCTempReg x: 0 b: RISCTempReg);
		at:  1 put: 16rB8 + (RISCTempReg bitAnd: 7);
		at:  2 put: (value bitAnd: 16rFF);
		at:  3 put: (value >> 8 bitAnd: 16rFF);
		at:  4 put: (value >> 16 bitAnd: 16rFF);
		at:  5 put: (value >> 24 bitAnd: 16rFF);
		at:  6 put: (value >> 32 bitAnd: 16rFF);
		at:  7 put: (value >> 40 bitAnd: 16rFF);
		at:  8 put: (value >> 48 bitAnd: 16rFF);
		at:  9 put: (value >> 56 bitAnd: 16rFF);
		at: 10 put: 16r41;
		at: 11 put: 16r48 + RISCTempReg. "The 48 will disambiguate between MoveCwR, PushCw and ArithCwR, which ends with a (self mod: ModReg RM: 0 RO: 0)"
	self assert: (machineCode at: 11) < 16r90. "see literalBeforeFollowingAddress:"
	^machineCodeSize := 12