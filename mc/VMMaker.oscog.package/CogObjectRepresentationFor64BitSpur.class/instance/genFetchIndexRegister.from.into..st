compile abstract instructions
genFetchIndexRegister: indexReg from: tableObj into: destReg
	"indexReg contains the 1-relative index of an element in tableObj.
	 Since BaseHeaderSize = BytesPerOop we can use it as a
	 zero-relative index from the beginning of the object."
	self assert: indexReg ~= destReg.
	cogit genMoveConstant: tableObj R: destReg.
	cogit MoveXwr: indexReg R: destReg R: destReg.
	^0