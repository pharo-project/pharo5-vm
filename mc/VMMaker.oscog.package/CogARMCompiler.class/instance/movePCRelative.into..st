generate machine code - support
movePCRelative: operand into: reg
	"Load a pc relative value into the register"
	| offset sign instr |
	offset := operand - (address + 8).
	sign := offset >= 0 ifTrue: [1] ifFalse: [0].
	instr := self ldr: reg rn: PC plus: sign imm: offset abs.
	self machineCodeAt: 0 put: instr.
	^4