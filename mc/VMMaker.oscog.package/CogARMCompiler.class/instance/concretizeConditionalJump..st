generate machine code - concretize
concretizeConditionalJump: conditionCode
	"Will get inlined into concretizeAt: switch."
	"Sizing/generating jumps.
		Jump targets can be to absolute addresses or other abstract instructions.
		Generating initial trampolines instructions may have no maxSize and be to absolute addresses.
		Otherwise instructions must have a machineCodeSize which must be kept to."
	<inline: true>
	| offset |
	offset := self computeJumpTargetOffsetPlus: 8.
 	self assert: (self isInImmediateJumpRange: offset).
	self machineCodeAt: 0 put: (self cond: conditionCode br: 0 offset: offset). "B offset"
	^machineCodeSize := 4