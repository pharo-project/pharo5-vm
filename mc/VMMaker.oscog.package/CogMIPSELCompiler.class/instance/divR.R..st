encoding - arithmetic
divR: dividendReg R: divisorReg
	self flag: #todo. "Ascertain what ISA revision adds this instruction"
	^self rtype: SPECIAL rs: dividendReg rt: divisorReg rd: 0 sa: 0 funct: DIV