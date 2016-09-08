generate machine code - concretize
concretizeJumpLongZero
	self unreachable. "Should have been rewritten by noteFollowingConditionalBranch:"
	^0