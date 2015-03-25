tests
testGenerateAdd
	"self new testGenerateAdd"
	|memory|
	self resetGen. "initialise important stuff"
		
	"test AddCqR"
	self concreteCompilerClass registersWithNamesDo: [ :reg :regName |
		#(0 16rF 16rFF) do:
			[:n| 
			self gen: AddCqR operand: n operand: reg]].
	memory := self generateInstructions.
	self disassembleOpcodesIn: memory to: Transcript	.
		
	self resetGen. "initialise important stuff"
	"test AddCwR"
	self concreteCompilerClass registersWithNamesDo: [ :reg :regName |
		#(16rFFFFFFFF 16r88888888) do:
			[:n|
			self gen: AddCwR operand: n operand: reg]].
	memory := self generateInstructions.
	self disassembleOpcodesIn: memory to: Transcript	.
