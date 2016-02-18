inline cacheing
rewriteConditionalJumpLongAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a conditional jump long to jump to target.  This version defaults to using
	 rewriteJumpLongAt:, which works for many ISAs.  Subclasses override if necessary."
	^self rewriteJumpLongAt: callSiteReturnAddress target: callTargetAddress