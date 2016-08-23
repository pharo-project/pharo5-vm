compile abstract instructions
popToReg: reg
	| inst |
	<var: #inst type: #'AbstractInstruction *'>
	spilled
		ifTrue:
			[inst := cogit PopR: reg]
		ifFalse:
			[type caseOf: {
				[SSBaseOffset]	-> [inst := cogit MoveMw: offset r: register R: reg].
				[SSConstant]	-> [inst := cogit genMoveConstant: constant R: reg].
				[SSRegister]	-> [inst := reg ~= register
												ifTrue: [cogit MoveR: register R: reg]
												ifFalse: [cogit Label]] }].