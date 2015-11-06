garbage collection
objRefInClosedPICAt: address
	"'mcpc' refers to the jump/branch instruction at the end of
	each cpic case. The objRef is the literal referenced by the
	 ldr	r6, [pc, #88]	; 16r5EAF00D type instruction preceeding this"
	<inline: true>
	^cogit backEnd literalBeforeFollowingAddress: address 