testing
setsConditionCodesFor: aConditionalJumpOpcode
	<inline: false>
	"Not really, but we can merge this in noteFollowingConditionalBranch:."
	opcode = XorRR ifTrue: [^true]. 
	opcode = ArithmeticShiftRightCqR ifTrue: [^true].
	self unreachable.
	^false