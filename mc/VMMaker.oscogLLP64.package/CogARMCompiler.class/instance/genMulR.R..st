abstract instructions
genMulR: regSource R: regDest
	"Use SMULL to produce a 64-bit result, explicitly in RISCTempReg,regDest. - ARM_ARM v7 DDI10406 pp. A8-354-5
	 By comparing RISCTempReg with regDest ASR 31(which effectively makes it 0 or -1) we know that the result being EQ means the hi reg and the top bit of the lo reg are the same - ie no overflow. The condition code can then be forced to oVerflow by use of MSR APSR_nzcvq, #1, lsl 28"
	| first |
	<var: 'first' type: #'AbstractInstruction *'>
	first := cogit gen: SMULL operand: regSource operand: regDest. "result in RISCTempReg,regDest"
	cogit gen: CMPSMULL operand: RISCTempReg operand: regDest.
	cogit gen: MSR operand: 1.
	^first