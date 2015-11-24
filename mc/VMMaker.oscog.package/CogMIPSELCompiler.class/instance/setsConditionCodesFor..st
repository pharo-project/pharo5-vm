testing
setsConditionCodesFor: aConditionalJumpOpcode
	<inline: false>
	opcode = XorRR ifTrue: [^true]. "Not really, but we can merge this in noteFollowingConditionalBranch:."
	self unreachable.
	^false