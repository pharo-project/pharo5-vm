encoding - arithmetic
sllvR: destReg R: leftReg R: rightReg
	^self rtype: SPECIAL rs: rightReg rt: leftReg rd: destReg sa: 0 funct: SLLV