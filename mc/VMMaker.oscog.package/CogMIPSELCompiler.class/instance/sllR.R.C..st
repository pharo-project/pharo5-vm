encoding - arithmetic
sllR: destReg R: sourceReg C: shiftAmount
	^self rtype: SPECIAL rs: 0 rt: sourceReg rd: destReg sa: shiftAmount funct: SLL