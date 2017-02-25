encoding - arithmetic
mfloR: destReg
	self flag: #todo. "Ascertain what ISA revision adds this instruction"
	^self rtype: SPECIAL rs: 0 rt: 0 rd: destReg sa: 0 funct: MFLO