encoding - arithmetic
addiuR: destReg R: srcReg C: imm
	^self itype: ADDIU rs: srcReg rt: destReg signedImmediate: imm