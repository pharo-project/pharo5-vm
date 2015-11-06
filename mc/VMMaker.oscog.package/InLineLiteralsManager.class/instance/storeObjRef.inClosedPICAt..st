garbage collection
storeObjRef: literal inClosedPICAt: address
	"'mcpc' refers to the jump/branch instruction at the end of
	each cpic case. The objRef is the literal referenced by the
	movI $0x0bada553, %ebx or
	ldr    r6, [pc, #64]    ; 0x000017d4 16rBADA553
	type instruction preceeding this"
	<var: #address type: #usqInt>
	<inline: true>
	cogit backEnd storeLiteral: literal beforeFollowingAddress: address