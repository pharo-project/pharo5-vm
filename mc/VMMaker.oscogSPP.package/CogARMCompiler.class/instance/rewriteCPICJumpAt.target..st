inline cacheing
rewriteCPICJumpAt: addressFollowingJump target: jumpTargetAddress
	"Rewrite a jump instruction to call a different target.  This variant is used to reset the 
	jumps in the prototype CPIC to suit each use,.   
	Answer the extent of the code change which is used to compute the range of the icache to flush."
	<var: #addressFollowingJump type: #usqInt>
	<var: #jumpTargetAddress type: #usqInt>
	<inline: true>
	^self rewriteTransferAt: addressFollowingJump target: jumpTargetAddress