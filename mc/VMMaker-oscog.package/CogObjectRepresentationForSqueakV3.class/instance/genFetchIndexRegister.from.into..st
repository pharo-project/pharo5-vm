compile abstract instructions
genFetchIndexRegister: indexReg from: tableObj into: destReg
	self assert: indexReg ~= destReg.
	cogit annotate: (cogit MoveCw: tableObj R: destReg) objRef: tableObj.
	cogit MoveXwr: indexReg R: destReg R: destReg.
	^0