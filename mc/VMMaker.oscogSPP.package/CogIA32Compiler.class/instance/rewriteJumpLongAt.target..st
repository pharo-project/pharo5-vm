inline cacheing
rewriteJumpLongAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a long jump instruction to jump to a different target.  This variant
	 is used to rewrite cached primitive calls.   Answer the extent of the
	 code change which is used to compute the range of the icache to flush."
	^self rewriteCallAt: callSiteReturnAddress target: callTargetAddress