abi
genSaveRegisters
	"Save the general purpose registers for a trampoline call."

	self assert: (R15 > RAX and: [R15 - RAX + 1 = 16]).
	R15 to: RAX by: -1 do: [:reg| cogit PushR: reg].
	^0