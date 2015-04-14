simulation stack
allocateOneRegister

	self ssTop type = SSRegister ifTrue: [ ^ self ssTop register].
	
	^ self allocateRegisterNotConflictingWith: 0
	