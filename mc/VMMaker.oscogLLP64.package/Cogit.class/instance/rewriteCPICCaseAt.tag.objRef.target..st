in-line cacheing
rewriteCPICCaseAt: followingAddress tag: newTag objRef: newObjRef target: newTarget
	"Rewrite the three values involved in a CPIC case.  Used by the initialize & extend CPICs.
	 c.f. expectedClosedPICPrototype:"

	"write the obj ref/operand via the second ldr"
	| classTagPC methodObjPC |
	methodObjPC := followingAddress - backEnd jumpLongConditionalByteSize - backEnd cmpC32RTempByteSize.
	backEnd storeLiteral: newObjRef beforeFollowingAddress: methodObjPC.

	classTagPC := followingAddress - backEnd jumpLongConditionalByteSize.
	"rewite the tag via the first ldr"	
	backEnd storeLiteral32: newTag beforeFollowingAddress: classTagPC.

	"write the jump address for the new target address"
	backEnd rewriteConditionalJumpLongAt: followingAddress target: newTarget