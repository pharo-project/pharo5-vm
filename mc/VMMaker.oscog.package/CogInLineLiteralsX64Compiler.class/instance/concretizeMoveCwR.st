generate machine code
concretizeMoveCwR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| value reg offset |
	value := operands at: 0.
	reg := operands at: 1.
	(self isAnInstruction: (cogit cCoerceSimple: value to: #'AbstractInstruction *')) ifTrue:
		[value := (cogit cCoerceSimple: value to: #'AbstractInstruction *') address].
	(cogit addressIsInCurrentCompilation: value) ifTrue:
		[offset := value - (address + 7).
		 machineCode
			at: 0 put: (self rexR: reg x: 0 b: 0);
			at: 1 put: 16r8D; "LoadEffectiveAddress"
			at: 2 put: (self mod: ModRegInd RM: 5 RO: reg);
			at: 3 put: (offset bitAnd: 16rFF);
			at: 4 put: (offset >> 8 bitAnd: 16rFF);
			at: 5 put: (offset >> 16 bitAnd: 16rFF);
			at: 6 put: (offset >> 24 bitAnd: 16rFF).
		^machineCodeSize := 7].
	machineCode
		at:  0 put: (self rexR: 0 x: 0 b: reg);
		at:  1 put: 16rB8 + (reg bitAnd: 7);
		at:  2 put: (value bitAnd: 16rFF);
		at:  3 put: (value >> 8 bitAnd: 16rFF);
		at:  4 put: (value >> 16 bitAnd: 16rFF);
		at:  5 put: (value >> 24 bitAnd: 16rFF);
		at:  6 put: (value >> 32 bitAnd: 16rFF);
		at:  7 put: (value >> 40 bitAnd: 16rFF);
		at:  8 put: (value >> 48 bitAnd: 16rFF);
		at:  9 put: (value >> 56 bitAnd: 16rFF).
	opcode = MoveCqR ifTrue:
		[^machineCodeSize := 10].
	"Add a nop to disambiguate between MoveCwR/PushCwR and ArithCwR, which ends with a (self mod: ModReg RM: 0 RO: 0)"
	machineCode at: 10 put: 16r90.
	self assert: (self mod: ModReg RM: 0 RO: 0) > 16r90.
	^machineCodeSize := 11