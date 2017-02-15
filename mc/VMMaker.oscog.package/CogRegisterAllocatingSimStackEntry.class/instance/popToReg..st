compile abstract instructions
popToReg: reg
	liveRegister ~= NoReg
		ifTrue: 
			[self deny: (type = SSRegister and: [register ~= liveRegister and: [cogit needsFrame]]).
			 spilled ifTrue: "This is rare, and in some cases it isn't even needed (e.g. frameful return) but we can't tell as yet."
				[cogit AddCq: objectRepresentation wordSize R: SPReg].
			 reg ~= liveRegister
				ifTrue: [cogit MoveR: liveRegister R: reg]
				ifFalse: [cogit Label]]
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

	(reg ~= TempReg and: [liveRegister = NoReg and: [type ~= SSRegister]]) ifTrue:
		[liveRegister := reg.
		 cogit copyLiveRegisterToCopiesOf: self]