simulation stack
allocateRegForStackTopTwoEntriesInto: binaryBlock
	"Answers registers for the 2 top values on stack. If the values are already in registers, answers
	these registers, else allocate registers not conflicting with each others."
	<inline: true>
	| topRegistersMask rTop rNext |
	
	topRegistersMask := 0.
	rTop := rNext := NoReg.
	
	self ssTop type = SSRegister ifTrue: 
		[ rTop := self ssTop register].
	(self ssValue: 1) type = SSRegister ifTrue: 
		[ topRegistersMask := self registerMaskFor: (rNext := (self ssValue: 1) register)].
	
	rTop = NoReg ifTrue:
		[ rTop := self allocateRegNotConflictingWith: topRegistersMask ].
	
	rNext = NoReg ifTrue:
		[ rNext := self allocateRegNotConflictingWith: (self registerMaskFor: rTop) ].

	self deny: (rTop = NoReg or: [rNext = NoReg]).

	^ binaryBlock value: rTop value: rNext