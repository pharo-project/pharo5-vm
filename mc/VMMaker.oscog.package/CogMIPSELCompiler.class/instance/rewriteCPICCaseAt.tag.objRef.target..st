inline cacheing
rewriteCPICCaseAt: followingAddress tag: newTag objRef: newObjRef target: newTarget
	"rewrite the three values involved in a CPIC case. Used by the create & extend cpcic methods"

	"lui at, tagHigh
	 ori at, at, tagLow
	 subu t0, s5, at (Cmp)
	 slt ... (Cmp)
	 slt ... (Cmp)
	 sltu ... (Cmp)
	 sltu ... (Cmp)
	 lui s4, objRefHigh
	 ori s4, s4, objRefLow
	 bne t0, zr, +12
	 nop (delay slot)
	 j target
	 nop (delay slot)
	 .... <-- followingAddress"

	cogit disassembleFrom: followingAddress - 52 to: followingAddress.
	self assert: (self opcodeAtAddress: followingAddress - 52) = LUI.
	self assert: (self opcodeAtAddress: followingAddress - 48) = ORI.
	self assert: (self functionAtAddress: followingAddress - 44) = SUBU.
	self assert: (self functionAtAddress: followingAddress - 40) = SLT.
	self assert: (self functionAtAddress: followingAddress - 36) = SLT.
	self assert: (self functionAtAddress: followingAddress - 32) = SLTU.
	self assert: (self functionAtAddress: followingAddress - 28) = SLTU.
	self assert: (self opcodeAtAddress: followingAddress - 24) = LUI.
	self assert: (self opcodeAtAddress: followingAddress - 20) = ORI.
	self assert: (self opcodeAtAddress: followingAddress - 16) = BNE.
	self assert: (objectMemory longAt: followingAddress - 12) = self nop.
	self assert: (self opcodeAtAddress: followingAddress - 8) = J.
	self assert: (objectMemory longAt: followingAddress - 4) = self nop.
	
	self literalAtAddress: followingAddress - 48 put: newTag.
	self literalAtAddress: followingAddress - 20 put: newObjRef.
	self rewriteJTypeAtAddress: followingAddress - 8 target: newTarget.

	cogit disassembleFrom: followingAddress - 52 to: followingAddress.
	self assert: (self opcodeAtAddress: followingAddress - 52) = LUI.
	self assert: (self opcodeAtAddress: followingAddress - 48) = ORI.
	self assert: (self functionAtAddress: followingAddress - 44) = SUBU.
	self assert: (self functionAtAddress: followingAddress - 40) = SLT.
	self assert: (self functionAtAddress: followingAddress - 36) = SLT.
	self assert: (self functionAtAddress: followingAddress - 32) = SLTU.
	self assert: (self functionAtAddress: followingAddress - 28) = SLTU.
	self assert: (self opcodeAtAddress: followingAddress - 24) = LUI.
	self assert: (self opcodeAtAddress: followingAddress - 20) = ORI.
	self assert: (self opcodeAtAddress: followingAddress - 16) = BNE.
	self assert: (objectMemory longAt: followingAddress - 12) = self nop.
	self assert: (self opcodeAtAddress: followingAddress - 8) = J.
	self assert: (objectMemory longAt: followingAddress - 4) = self nop.

	^56