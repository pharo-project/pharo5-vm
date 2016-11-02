accessing
zeroOpcodeIndex
	"Access for the object representations when they need to prepend code to trampolines."
	"Eliminate stale dependent info."
	0 to: opcodeIndex - 1 do:
		[:i| (abstractOpcodes at: i) dependent: nil].
	self zeroOpcodeIndexForNewOpcodes