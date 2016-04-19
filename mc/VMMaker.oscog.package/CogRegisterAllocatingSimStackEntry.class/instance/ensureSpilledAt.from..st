compile abstract instructions
ensureSpilledAt: baseOffset from: baseRegister
	| inst |
	<var: #inst type: #'AbstractInstruction *'>
	spilled ifTrue:
		[type = SSSpill ifTrue:
			[self assert: (offset = baseOffset and: [register = baseRegister]).
			 ^self]].
	self assert: type ~= SSSpill.
	cogit traceSpill: self.
	type = SSConstant
		ifTrue:
			[inst := cogit genPushConstant: constant]
		ifFalse:
			[type = SSBaseOffset
				ifTrue:
					[ liveRegister = NoReg
						ifTrue: 
							[cogit MoveMw: offset r: register R: TempReg.
					 		 inst := cogit PushR: TempReg ]
						ifFalse: [ inst := cogit PushR: liveRegister]]
				ifFalse:
					[self assert: type = SSRegister.
					 inst := cogit PushR: register].
			 type := SSSpill.
			 offset := baseOffset.
			 register := baseRegister].
	spilled := true.