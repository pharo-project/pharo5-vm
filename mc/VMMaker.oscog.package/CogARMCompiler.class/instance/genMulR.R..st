abstract instructions
genMulR: regSource R: regDest
	"Use SMULL to produce a 64-bit result, implicitly in TempReg,RISCTempReg.
	 Test the top word for 0 or 1 and set oVerflow if not equal.  Move result in
	 TempReg into regDest."

	cogit
		gen: SMULL operand: regSource operand: regDest; "result in TempReg,RISCTempReg"
		gen: AddCqR operand: 1 operand: RISCTempReg; "turn -1,0 into 0,1"
		gen: AddCqR operand: -1 operand: RISCTempReg; "turn 0,1 into not oVerflow"
		gen: MoveRR operand: TempReg operand: regDest