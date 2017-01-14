full transfer run-time support
rewriteJumpFullAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a JumpFull instruction to jump to a different target.  This variant is used to rewrite cached primitive calls.
	 Answer the extent of the code change which is used to compute the range of the icache to flush.
	 On x64 this is a rewrite of
		movq #64bits, %rax : 48 A1 b0 b1 b2 b3 b4 b5 b6 b7
		jmp %rax : FF E0 "
	^self rewriteCallFullAt: callSiteReturnAddress target: callTargetAddress