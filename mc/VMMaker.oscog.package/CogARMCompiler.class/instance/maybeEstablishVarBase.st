abstract instructions
maybeEstablishVarBase
	"The receiver has a VarBaseReg; generate the code to set it to its value."
	cogit MoveCq: cogit varBaseAddress R: VarBaseReg