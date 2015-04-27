simulation stack
allocateRegForStackTopTwoEntriesInto: binaryBlock
	<inline: true>
	| topRegistersMask rTop rNext |
	
	topRegistersMask := 0.
	
	self ssTop type = SSRegister ifTrue: 
		[ rTop := self ssTop register].
	(self ssValue: 1) type = SSRegister ifTrue: 
		[ topRegistersMask := self registerMaskFor: (rNext := (self ssValue: 1) register)].
	
	rTop ifNil: [ rTop := self allocateRegNotConflictingWith: topRegistersMask ].
	
	rNext ifNil: [ rNext := self allocateRegNotConflictingWith: (self registerMaskFor: rTop) ].
	
	^ binaryBlock value: rTop value: rNext
	
	