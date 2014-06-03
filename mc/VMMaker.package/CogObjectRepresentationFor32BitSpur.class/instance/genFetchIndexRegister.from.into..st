compile abstract instructions
genFetchIndexRegister: indexReg from: tableObj into: destReg
	"indexReg contains the 1-relative index of an element in tableObj.
	 Since BaseHeaderSize > BytesPerOop we must adjust it to use
	 it as a zero-relative index from the beginning of the object."
	self assert: indexReg ~= destReg.
	cogit AddCq: objectMemory baseHeaderSize / objectMemory wordSize - 1 R: indexReg.
	cogit annotate: (cogit MoveCw: tableObj R: destReg) objRef: tableObj.
	cogit MoveXwr: indexReg R: destReg R: destReg.
	^0