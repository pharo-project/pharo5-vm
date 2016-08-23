full transfer run-time support
rewriteCallFullAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a CallFull instruction to call a different target.  This variant is used to rewrite cached primitive calls.
	 Answer the extent of the code change which is used to compute the range of the icache to flush.
	 This defaults to rewriteCallAt:target:; processors that differentiate between Call and CallFull will override."
	^self rewriteCallAt: callSiteReturnAddress target: callTargetAddress