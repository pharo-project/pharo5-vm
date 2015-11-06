inline cacheing
rewriteCPICCaseAt: followingAddress tag: newTag objRef: newObjRef target: newTarget
	"rewrite the three values involved in a CPIC case. Used by the create & extend cpcic methods"

	"ARM CPIC cases are
	ldr TempReg, [pc relative -> tag]
	cmp TempReg0, TempReg 
	ldr SendNumArgs, [pc relative -> obj ref]
	beq target"
	"rewite the tag via the first ldr"	
	objectMemory longAt: (self pcRelativeAddressAt: followingAddress - 16) put: newTag.

	"write the obj ref/operand via the second ldr"
	objectMemory longAt: (self pcRelativeAddressAt: followingAddress - 8) put: newObjRef.
	
	"write the jump address for the new target address"
	self rewriteJumpLongAt: followingAddress target: newTarget