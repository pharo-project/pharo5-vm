inline cacheing
rewriteJumpFullAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a full jump instruction to jump to a different target.  This variant
	 is used to rewrite cached primitive calls.   Answer the extent of the
	 code change which is used to compute the range of the icache to flush."
	<inline: true>
	^self
		rewriteFullTransferAt: callSiteReturnAddress
		target: callTargetAddress
		expectedInstruction: 16rE12FFF1C