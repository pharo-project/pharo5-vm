abi
genSaveRegsForCCall
	"Save the general purpose registers for a call into the C run-time from a trampoline."

	self assert: (EDI > EAX and: [EDI - EAX + 1 = 8]).
	EDI to: EAX by: -1 do:
		[:reg|
		 (reg between: ESP and: EBP) ifFalse:
			[cogit PushR: reg]].
	^0