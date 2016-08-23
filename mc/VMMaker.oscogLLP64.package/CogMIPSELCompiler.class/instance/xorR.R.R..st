encoding - arithmetic
xorR: destReg R: leftReg R: rightReg
	^self rtype: SPECIAL rs: leftReg rt: rightReg rd: destReg sa: 0 funct: XOR