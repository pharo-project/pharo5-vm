garbage collection
objRefInClosedPICAt: mcpc
	"'mcpc' refers to the jump/branch instruction at the end of
	each cpic case. The method objRef is the method object referenced by the
	movI $0x0bada553, %ebx 
	or
	ldr    r6, [pc, #64]    ; 0x000017d4 16rBADA553
	type instruction preceeding this"
	<inline: true>
	^cogit backEnd literalBeforeFollowingAddress: mcpc