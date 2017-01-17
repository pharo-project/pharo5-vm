encoding - memory
lwR: destReg base: baseReg offset: offset
	^self itype: LW rs: baseReg rt: destReg signedImmediate: offset