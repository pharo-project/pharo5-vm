generate machine code
concretizeConditionalJump: conditionCode
	"Will get inlined into concretizeAt: switch."
	"Sizing/generating jumps.
		Jump targets can be to absolute addresses or other abstract instructions.
		Generating initial trampolines instructions may have no maxSize and be to absolute addresses.
		Otherwise instructions must have a machineCodeSize which must be kept to."
	<inline: true>
	| offset |
	offset := self computeJumpTargetOffsetPlus: 2.
	(machineCodeSize = 0 "size not determined because no sizeJump pass; generating initial trampolines"
		ifTrue: [self isQuick: offset]
		ifFalse: [machineCodeSize = 2]) ifTrue:
		[machineCode
			at: 0 put: 16r70 + conditionCode;
			at: 1 put: (offset bitAnd: 16rFF).
		 ^machineCodeSize := 2].
	^self concretizeConditionalJumpLong: conditionCode