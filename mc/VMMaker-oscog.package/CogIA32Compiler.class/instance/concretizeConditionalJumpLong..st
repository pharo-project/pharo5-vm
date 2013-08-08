generate machine code
concretizeConditionalJumpLong: conditionCode
	"Will get inlined into concretizeAt: switch."
	"Sizing/generating jumps.
		Jump targets can be to absolute addresses or other abstract instructions.
		Generating initial trampolines instructions may have no maxSize and be to absolute addresses.
		Otherwise instructions must have a machineCodeSize which must be kept to."
	<inline: true>
	| offset |
	offset := self computeJumpTargetOffsetPlus: 6.
	machineCode
		at: 0 put: 16r0F;
		at: 1 put: 16r80 + conditionCode;
		at: 2 put: (offset bitAnd: 16rFF);
		at: 3 put: (offset >> 8 bitAnd: 16rFF);
		at: 4 put: (offset >> 16 bitAnd: 16rFF);
		at: 5 put: (offset >> 24 bitAnd: 16rFF).
	^machineCodeSize := 6