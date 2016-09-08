inline cacheing
rewriteCallAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a call instruction to call a different target.  This variant is used to link PICs
	 in ceSendMiss et al,.   
	Answer the extent of the code change which is used to compute the range of the icache to flush."
	<var: #callSiteReturnAddress type: #usqInt>
	<var: #callTargetAddress type: #usqInt>
	^self rewriteTransferAt: callSiteReturnAddress target: callTargetAddress