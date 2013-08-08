simulation stack
ssStorePop: popBoolean toPreferredReg: preferredReg
	"Store or pop the top simulated stack entry to a register.
	 Pop to preferredReg if the entry is not itself a register.
	 Answer the actual register the result ends up in."
	| actualReg |
	actualReg := preferredReg.
	popBoolean
		ifTrue: [(self ssTop type = SSRegister and: [self ssTop spilled not])
					ifTrue: [self assert: self ssTop annotateUse not.
							actualReg := self ssTop register]
					ifFalse: [self ssTop popToReg: preferredReg].
				self ssPop: 1]
		ifFalse: [self ssTop type = SSRegister
					ifTrue: [self assert: self ssTop annotateUse not.
							actualReg := self ssTop register]
					ifFalse: [self ssTop storeToReg: preferredReg]].
	^actualReg