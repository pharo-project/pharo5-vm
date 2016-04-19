bytecode generator support
mergeCurrentSimStackWith: mergeSimStack
	<var: #mergeSimStack type: #'SimStackEntry *'>
	<var: #currentSSEntry type: #'SimStackEntry *'>
	<var: #expectedSSEntry type: #'SimStackEntry *'>
	"At merge point the cogit expects the stack to be in the same state as mergeSimStack.
	The logic is very naive, we align the existing state from the current stack to the merge stack
	from simStackPtr to methodOrBlockNumTemps, and if a conflict happen, we flush what remains
	to be merged."
	self flag: #TODO. "we could have a better algorithm with the current set of live registers to avoid flushing"
	simStackPtr to: methodOrBlockNumTemps by: -1 do:
		[:i|
			| currentSSEntry expectedSSEntry |
			currentSSEntry := self simStackAt: i.
			expectedSSEntry := self simStack: mergeSimStack at: i.
			expectedSSEntry type
				caseOf: {
					[SSBaseOffset]	-> [ self assert: (expectedSSEntry register = ReceiverResultReg or: [ expectedSSEntry register = FPReg ]).
										(expectedSSEntry register = ReceiverResultReg and: [needsFrame]) ifTrue: 
											[optStatus isReceiverResultRegLive ifFalse: 
												[self ssFlushFrom: i - 1 upThroughRegister: ReceiverResultReg.
											 	 self putSelfInReceiverResultReg ].
											 optStatus isReceiverResultRegLive: true].  ].
					[SSSpill]		-> [currentSSEntry ensureSpilledAt: (self frameOffsetOfTemporary: i) from: FPReg].
					[SSConstant]	-> [self assert: expectedSSEntry liveRegister notNil. 
										currentSSEntry storeToReg: expectedSSEntry liveRegister ].
					[SSRegister]	-> [(currentSSEntry type = SSRegister and: [currentSSEntry register = expectedSSEntry register])
											ifFalse: 
												[ self ssFlushFrom: i - 1 upThroughRegister: expectedSSEntry register.
												currentSSEntry storeToReg: expectedSSEntry register ] ]}.
			 ]