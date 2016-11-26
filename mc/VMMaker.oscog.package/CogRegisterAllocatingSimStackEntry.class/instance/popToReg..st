compile abstract instructions
popToReg: reg
	<var: #inst type: #'AbstractInstruction *'>
	liveRegister ~= NoReg
		ifTrue: 
			[self deny: spilled.
			 reg ~= liveRegister
				ifTrue: [cogit MoveR: liveRegister R: reg]
				ifFalse: [cogit Label] ]
		ifFalse: 
			[spilled
				ifTrue:
					[cogit PopR: reg]
				ifFalse:
					[type caseOf: {
						[SSBaseOffset]	-> [cogit MoveMw: offset r: register R: reg].
						[SSConstant]	-> [cogit genMoveConstant: constant R: reg].
						[SSRegister]	-> [reg ~= register
												ifTrue: [cogit MoveR: register R: reg]
												ifFalse: [cogit Label]] }]].
	reg ~= TempReg ifTrue:
		[liveRegister := reg.
		 cogit observeLiveRegisterIn: self]