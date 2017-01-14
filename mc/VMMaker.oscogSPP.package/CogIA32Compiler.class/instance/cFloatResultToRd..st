abi
cFloatResultToRd: reg
	cogit gen: FSTPD operand: -8 operand: SPReg .
	cogit MoveM64: -8 r: SPReg Rd: reg