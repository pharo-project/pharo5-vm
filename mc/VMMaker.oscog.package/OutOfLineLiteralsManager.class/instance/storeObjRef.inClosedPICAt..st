garbage collection
storeObjRef: literal inClosedPICAt: address
	"'mcpc' refers to the jump/branch instruction at the end of
	each cpic case. The objRef is the literal referenced by the
	 ldr	r6, [pc, #88]	; 16r5EAF00D type instruction preceeding this"
	<var: #address type: #usqInt>
	<inline: true>
	cogit backEnd storeLiteral: literal beforeFollowingAddress: address