encoding - arithmetic
sraR: destReg R: sourceReg C: shiftAmount
	^self rtype: SPECIAL rs: 0 rt: sourceReg rd: destReg sa: shiftAmount funct: SRA