testing
shiftSetsConditionCodesFor: aConditionalJumpOpcode
	"check what flags the opcdoe needs setting - ARM doesn't set V when simply MOVing"
		^aConditionalJumpOpcode caseOf:
		{	[JumpNegative]	->	[true].
			[JumpZero]	->	[true].
			[JumpLess]	->	[true].
		}
		otherwise: [self halt: 'unhandled opcode in setsConditionCodesFor:'. false]