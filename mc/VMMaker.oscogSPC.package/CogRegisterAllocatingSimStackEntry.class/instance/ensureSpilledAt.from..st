compile abstract instructions
ensureSpilledAt: baseOffset from: baseRegister
	spilled ifTrue:
		[type = SSSpill ifTrue:
			[self assert: (offset = baseOffset and: [register = baseRegister]).
			 liveRegister := NoReg.
			 ^self]].
	self assert: type ~= SSSpill.
	cogit traceSpill: self.
	type = SSConstant
		ifTrue:
			[cogit genPushConstant: constant]
		ifFalse:
			[type = SSBaseOffset
				ifTrue:
					[liveRegister = NoReg
						ifTrue: 
							[cogit MoveMw: offset r: register R: TempReg.
					 		 cogit PushR: TempReg]
						ifFalse: [cogit PushR: liveRegister]]
				ifFalse:
					[self assert: type = SSRegister.
					 cogit PushR: register].
			 type := SSSpill.
			 offset := baseOffset.
			 register := baseRegister].
	liveRegister := NoReg.
	spilled := true