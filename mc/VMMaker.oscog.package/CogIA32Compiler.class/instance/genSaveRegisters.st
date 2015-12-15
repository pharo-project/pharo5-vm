abi
genSaveRegisters
	"Save the general purpose registers for a trampoline call."

	self assert: (EDI > EAX and: [EDI - EAX + 1 = 8]).
	EDI to: EAX by: -1 do:
		[:reg|
		 (reg between: ESP and: EBP) ifFalse:
			[cogit PushR: reg]].
	^0