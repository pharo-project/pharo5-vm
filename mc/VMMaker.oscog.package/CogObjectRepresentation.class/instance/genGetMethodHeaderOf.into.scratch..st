compile abstract instructions
genGetMethodHeaderOf: methodReg into: headerReg scratch: scratchReg
	"Get the method header (first word) of a CompiledMethod into headerReg.
	 Deal with the method possibly being cogged."
	| jumpNotCogged |
	<var: #jumpNotCogged type: #'AbstractInstruction *'>
	cogit MoveMw: objectMemory baseHeaderSize r: methodReg R: headerReg.
	jumpNotCogged := self genJumpSmallInteger: headerReg scratchReg: scratchReg.
	cogit MoveMw: (cogit offset: CogMethod of: #methodHeader) r: headerReg R: headerReg.
	jumpNotCogged jmpTarget: cogit Label.
	^0