compile abstract instructions
storeToReg: reg
	liveRegister ~= NoReg
		ifTrue:
			[self deny: (type = SSRegister and: [register ~= liveRegister]).
			 reg ~= liveRegister
				ifTrue: [cogit MoveR: liveRegister R: reg]
				ifFalse: [cogit Label]]
		ifFalse:
			[type caseOf: {
				[SSBaseOffset]	-> [cogit MoveMw: offset r: register R: reg].
				[SSSpill]		-> [cogit MoveMw: offset r: register R: reg].
				[SSConstant]	-> [cogit genMoveConstant: constant R: reg].
				[SSRegister]	-> [reg ~= register
											ifTrue: [cogit MoveR: register R: reg]
											ifFalse: [cogit Label]] }].

	(reg ~= TempReg and: [reg ~= liveRegister and: [type ~= SSRegister]]) ifTrue:
		[liveRegister := reg.
		 cogit copyLiveRegisterToCopiesOf: self]