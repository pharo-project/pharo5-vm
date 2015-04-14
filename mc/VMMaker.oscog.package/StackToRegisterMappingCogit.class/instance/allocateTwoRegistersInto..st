simulation stack
allocateTwoRegistersInto: binaryBlock
	<inline: true>
	| topRegistersMask rTop rNext |
	
	topRegistersMask := 0.
	
	self ssTop type = SSRegister ifTrue: 
		[ topRegistersMask := self registerMaskFor: (rTop := self ssTop register)].
	(self ssValue: 1) type = SSRegister ifTrue: 
		[ topRegistersMask := topRegistersMask bitOr: (self registerMaskFor: (rNext := (self ssValue: 1) register))].
	
	rTop ifNil: [ rTop := self allocateRegisterNotConflictingWith: topRegistersMask ].
	
	rNext ifNil: [ rNext := self allocateRegisterNotConflictingWith: (self registerMaskFor: rTop) ].
	
	^ binaryBlock value: rTop value: rNext
	
	