abstract instructions
genMulR: regSource R: regDest
	"Use SMULL to produce a 64-bit result, implicitly in TempReg,RISCTempReg.
	 Test the top word for 0 or 1 and set oVerflow if not equal.  Move result in
	 TempReg into regDest."
	<var: #inst type: #AbstractInstruction>

	cogit
		gen: SMULL operand: regSource operand: regDest; "result in TempReg,RISCTempReg"
		AddCq: 1 R: RISCTempReg; "turn -1,0 into 0,1"
		AddCq: -1 R: RISCTempReg; "turn 0,1 into not oVerflow"
		MoveR: TempReg R: regDest