encoding - arithmetic
multR: leftReg R: rightReg
	self flag: #todo. "Ascertain what ISA revision adds this instruction"
	^self rtype: SPECIAL rs: leftReg rt: rightReg rd: 0 sa: 0 funct: MULT