simulation stack
allocateRegForStackTopThreeEntriesInto: trinaryBlock thirdIsReceiver: thirdIsReceiver
	"Answers registers for the 3 top values on stack. If the values are already in registers, answers
	these registers, else allocate registers not conflicting with each others.
	If thirdIsReceiver is true, allocate ReceiverResultReg for stackTop - 2 (for ceStoreCheck)."
	<inline: true>
	| topRegistersMask rTop rNext rThird |
	
	topRegistersMask := 0.
	
	(self ssTop type = SSRegister and: [ thirdIsReceiver not or: [ self ssTop register ~= ReceiverResultReg ] ]) ifTrue: 
		[ topRegistersMask := self registerMaskFor: (rTop := self ssTop register)].
	((self ssValue: 1) type = SSRegister and: [ thirdIsReceiver not or: [ (self ssValue: 1) register ~= ReceiverResultReg ] ]) ifTrue: 
		[ topRegistersMask := topRegistersMask bitOr: (self registerMaskFor: (rNext := (self ssValue: 1) register))].
	((self ssValue: 2) type = SSRegister and: [thirdIsReceiver not or: [ (self ssValue: 2) register = ReceiverResultReg ] ]) ifTrue: 
		[ topRegistersMask := topRegistersMask bitOr: (self registerMaskFor: (rThird := (self ssValue: 2) register))].
	
	rThird ifNil: 
		[ thirdIsReceiver 
			ifTrue:
				[ rThird := ReceiverResultReg.  "Free ReceiverResultReg if it was not free"
				self ssAllocateRequiredReg: ReceiverResultReg.
				optStatus isReceiverResultRegLive: false ]
			ifFalse: [ rThird := self allocateRegNotConflictingWith: topRegistersMask ].
		topRegistersMask := topRegistersMask bitOr: (self registerMaskFor: rThird) ].
	
	rTop ifNil: [ 
		rTop := self allocateRegNotConflictingWith: topRegistersMask.
		topRegistersMask := topRegistersMask bitOr: (self registerMaskFor: rTop) ].
	
	rNext ifNil: [ rNext := self allocateRegNotConflictingWith: topRegistersMask ].
	
	^ trinaryBlock value: rTop value: rNext value: rThird
	
	