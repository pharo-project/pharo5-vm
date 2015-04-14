simulation stack
allocateTwoRegistersInto: binaryBlock
	| topRegistersMask rTop rNext |
	topRegistersMask := 0.
	self ssTop type = SSRegister ifTrue: 
		[ topRegistersMask := self registerMaskFor: (rTop := self ssTop register)].
	(self ssValue: 1) type = SSRegister ifTrue: 
		[ topRegistersMask := topRegistersMask bitOr: (self registerMaskFor: (rNext := (self ssValue: 1) register))].
	(rTop notNil and: [rNext notNil]) ifTrue: 
		[ ^ binaryBlock value: rTop value: rNext ].
	
	rTop ifNotNil:
		[ rNext := backEnd availableRegisterOrNilFor: (self liveRegisters bitOr: topRegistersMask).
		rNext ifNil: 
			[ rNext := backEnd availableRegisterOrNilFor: topRegistersMask. 
			self assert: rNext notNil.
			self ssAllocateRequiredRegMask: rNext upThrough: simStackPtr - 1 ].
		^ binaryBlock value: rTop value: rNext ].
	
	rNext ifNotNil:
		[ rTop := backEnd availableRegisterOrNilFor: (self liveRegisters bitOr: topRegistersMask).
		rTop ifNil: 
			[ rTop := backEnd availableRegisterOrNilFor: topRegistersMask. 
			self assert: rTop notNil.
			self ssAllocateRequiredRegMask: rTop upThrough: simStackPtr - 2 ].
		^ binaryBlock value: rTop value: rNext ].
	
	rTop := backEnd availableRegisterOrNilFor: self liveRegisters.
	topRegistersMask := rTop ifNotNil: [ self registerMaskFor: rTop ] ifNil: [0].
	rNext := backEnd availableRegisterOrNilFor: (self liveRegisters bitOr: topRegistersMask).
	(rTop notNil and: [ rNext notNil ]) ifTrue: 
		[ ^ binaryBlock value: rTop value: rNext ].
	
	rTop ifNil: [ ^ self spillTwoRegistersInto: binaryBlock ].
	
	"rNext isNil. rTop is allocated"
	rNext := backEnd availableRegisterOrNilFor: topRegistersMask. 
	self assert: rNext notNil.
	self ssAllocateRequiredRegMask: rNext upThrough: simStackPtr - 1.
	^ binaryBlock value: rTop value: rNext 
	