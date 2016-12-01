bytecode generator support
moveSimStackConstantsToRegisters
	<inline: true>
	<var: #desc type: #'SimStackEntry *'>
	self flag: 'I think this should be done at the merge point if required.  e.g. self at: 1 put: (expr ifTrue: [a] ifFalse: [b]) does not need to assign'. 
	(simSpillBase max: 0) to: simStackPtr do: 
		[:i| | desc reg |
		 desc := self simStackAt: i.
		 (desc type = SSConstant and: [desc liveRegister = NoReg]) ifTrue:
			[reg := self allocateRegNotConflictingWith: 0.
			 reg ~= NoReg ifTrue:
				[desc storeToReg: reg]]]