full transfer run-time support
rewriteJumpFullAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a JumpFull instruction to jump to a different target.  This variant is used to rewrite cached primitive calls.
	 Answer the extent of the code change which is used to compute the range of the icache to flush.
	 This defaults to rewriteJumpLongAt:target:; processors that differentiate between Jump and JumpFull will override."
	^self rewriteJumpLongAt: callSiteReturnAddress target: callTargetAddress