abi
cFloatResultToRs: reg
	cogit gen: FSTPS operand: -4 operand: SPReg.
	cogit MoveM32: -4 r: SPReg Rs: reg