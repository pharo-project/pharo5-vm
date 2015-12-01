inline cacheing
rewriteCPICJumpAt: addressFollowingJump target: jumpTargetAddress
	"Rewrite a jump instruction to call a different target.  This variant is used to reset the 
	jumps in the prototype CPIC to suit each use,.   
	Answer the extent of the code change which is used to compute the range of the icache to flush."
	<var: #addressFollowingJump type: #usqInt>
	<var: #jumpTargetAddress type: #usqInt>
	
	"self CmpR: ClassReg R: TempReg.
	^self JumpNonZero: 0"
	
	"bne s5, s3, +156 ; =BE7C
	 nop (delay slot)
	 .... <-- addressFollowingJump"
	
	self assert: (self opcodeAtAddress: addressFollowingJump - 8) = BNE.
	self assert: (objectMemory longAt: addressFollowingJump - 4) = self nop.
	"cogit disassembleFrom: addressFollowingJump - 8 to: addressFollowingJump."
	
	self rewriteITypeBranchAtAddress: addressFollowingJump - 8 target: jumpTargetAddress.
	
	self assert: (self opcodeAtAddress: addressFollowingJump - 8) = BNE.
	self assert: (objectMemory longAt: addressFollowingJump - 4) = self nop.
	"cogit disassembleFrom: addressFollowingJump - 8 to: addressFollowingJump."