compile abstract instructions
popToReg: reg
	spilled
		ifTrue:
			[cogit PopR: reg]
		ifFalse:
			[type caseOf: {
				[SSBaseOffset]	-> [cogit MoveMw: offset r: register R: reg].
				[SSConstant]	-> [cogit genMoveConstant: constant R: reg].
				[SSRegister]	-> [reg ~= register
										ifTrue: [cogit MoveR: register R: reg]
										ifFalse: [cogit Label]] }]