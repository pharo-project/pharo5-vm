simulation stack
allocateRegForStackTopThreeEntriesInto: trinaryBlock thirdIsReceiver: thirdIsReceiver
	"Answers registers for the 3 top values on stack. If the values are already in registers, answers
	these registers, else allocate registers not conflicting with each others.
	If thirdIsReceiver is true, allocate ReceiverResultReg for stackTop - 2 (for ceStoreCheck)."
	<inline: true>
	| topRegistersMask rTop rNext rThird |
	
	topRegistersMask := 0.
	rTop := rNext := rThird := NoReg.
	
	(self ssTop registerOrNone ~= NoReg and: [ thirdIsReceiver not or: [ self ssTop registerOrNone ~= ReceiverResultReg ] ]) ifTrue: 
		[ topRegistersMask := self registerMaskFor: (rTop := self ssTop registerOrNone)].
	((self ssValue: 1) registerOrNone ~= NoReg and: [ thirdIsReceiver not or: [ (self ssValue: 1) registerOrNone ~= ReceiverResultReg ] ]) ifTrue: 
		[ topRegistersMask := topRegistersMask bitOr: (self registerMaskFor: (rNext := (self ssValue: 1) registerOrNone))].
	((self ssValue: 2) registerOrNone ~= NoReg and: [thirdIsReceiver not or: [ (self ssValue: 2) registerOrNone = ReceiverResultReg ] ]) ifTrue: 
		[ topRegistersMask := topRegistersMask bitOr: (self registerMaskFor: (rThird := (self ssValue: 2) registerOrNone))].
	
	rThird = NoReg ifTrue:
		[ thirdIsReceiver 
			ifTrue:
				[ rThird := ReceiverResultReg.  "Free ReceiverResultReg if it was not free"
				self ssAllocateRequiredReg: ReceiverResultReg.
				self voidReceiverResultRegContainsSelf ]
			ifFalse: [ rThird := self allocateRegNotConflictingWith: topRegistersMask ].
		topRegistersMask := topRegistersMask bitOr: (self registerMaskFor: rThird) ].
	
	rTop = NoReg ifTrue:
		[ rTop := self allocateRegNotConflictingWith: topRegistersMask.
		  topRegistersMask := topRegistersMask bitOr: (self registerMaskFor: rTop) ].
	
	rNext = NoReg ifTrue:
		[ rNext := self allocateRegNotConflictingWith: topRegistersMask ].

	self deny: (rTop = NoReg or: [rNext = NoReg or: [rThird = NoReg]]).

	^ trinaryBlock value: rTop value: rNext value: rThird