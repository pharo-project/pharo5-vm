compile abstract instructions
inverseBranchFor: opcode
	opcode caseOf: {
		[JumpLongZero]		->	[^JumpLongNonZero].
		[JumpLongNonZero]	->	[^JumpLongZero].
		[JumpZero]				->	[^JumpNonZero].
		[JumpNonZero]			->	[^JumpZero].
		[JumpNegative]			->	[^JumpNonNegative].
		[JumpNonNegative]		->	[^JumpNegative].
		[JumpOverflow]			->	[^JumpNoOverflow].
		[JumpNoOverflow]		->	[^JumpOverflow].
		[JumpCarry]			->	[^JumpNoCarry].
		[JumpNoCarry]			->	[^JumpCarry].
		[JumpLess]				->	[^JumpGreaterOrEqual].
		[JumpGreaterOrEqual]	->	[^JumpLess].
		[JumpGreater]			->	[^JumpLessOrEqual].
		[JumpLessOrEqual]		->	[^JumpGreater].
		[JumpBelow]			->	[^JumpAboveOrEqual].
		[JumpAboveOrEqual]	->	[^JumpBelow].
		[JumpAbove]			->	[^JumpBelowOrEqual].
		[JumpBelowOrEqual]	->	[^JumpAbove] }.
	self error: 'invalid opcode for inverse'.
	^0