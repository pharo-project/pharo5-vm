abi
genSaveRegisters
	"Save the general purpose registers for a trampoline call."

	self assert: (EDI > EAX and: [EDI - EAX + 1 = 6]).
	EDI to: EAX by: -1 do: [:reg| cogit PushR: reg].
	^0