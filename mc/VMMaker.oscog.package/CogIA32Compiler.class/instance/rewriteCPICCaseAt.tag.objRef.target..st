inline cacheing
rewriteCPICCaseAt: followingAddress tag: newTag objRef: newObjRef target: newTarget
	"Rewrite the three values involved in a CPIC case. Used by the initialize & extend CPICs."

	"IA32 CPIC cases are
	 cmpl $0x newTag, %eax
	 movl $0x newObjRef, %ebx
	 jz .+0x newTarget (0x00010924)"

	"rewite the tag via the first ldr"	
	self storeLiteral: newTag beforeFollowingAddress: (followingAddress -11).

	"write the obj ref/operand via the second ldr"
	self storeLiteral: newObjRef beforeFollowingAddress: (followingAddress - 6).
	
	"write the jump address for the new target address"
	self rewriteJumpLongAt: followingAddress target: newTarget