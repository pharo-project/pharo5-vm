compile abstract instructions
storeToReg: reg
	| inst |
	<var: #inst type: #'AbstractInstruction *'>
	liveRegister ~= NoReg
		ifTrue:
			[inst := reg ~= liveRegister
							ifTrue: [cogit MoveR: liveRegister R: reg]
							ifFalse: [cogit Label]]
		ifFalse:
			[type caseOf: {
				[SSBaseOffset]	-> [inst := cogit MoveMw: offset r: register R: reg].
				[SSSpill]		-> [inst := cogit MoveMw: offset r: register R: reg].
				[SSConstant]	-> [inst := cogit genMoveConstant: constant R: reg].
				[SSRegister]	-> [inst := reg ~= register
												ifTrue: [cogit MoveR: register R: reg]
												ifFalse: [cogit Label]] }].
	reg ~= TempReg ifTrue: [ liveRegister := reg ]