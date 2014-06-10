compile abstract instructions
genFetchIndexRegister: indexReg from: tableObj into: destReg
	"indexReg contains the 1-relative index of an element in tableObj."
	self subclassResponsibility