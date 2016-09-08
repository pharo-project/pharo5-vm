bytecode generator support
moveSimStackConstantsToRegisters
	<inline: true>
	(simSpillBase max: 0) to: simStackPtr do: 
		[:i|
			| desc |
			desc := self simStackAt: i.
			(desc type = SSConstant and: [desc liveRegister = NoReg])
				ifTrue: [ desc storeToReg: (self allocateRegNotConflictingWith: 0) ] ]