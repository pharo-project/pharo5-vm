inline cacheing
jumpLongConditionalTargetBeforeFollowingAddress: mcpc
	"Extract the target from a long conditional jump.  On many ISAs this si the same as
	 extracting the target from a long unconditional jump, so we provide the default here.
	 Processors such as MIPS override as appropriate."
	<inline: true>
	^self jumpLongTargetBeforeFollowingAddress: mcpc