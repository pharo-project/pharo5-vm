abstract instructions
movePCRelative: operand into: reg
"Load a pc relative value into the register"
	| offset sign |
	offset := operand - address +8.
	sign := offset > 0 ifTrue:[1] ifFalse:[0].
	self ldr: reg rn: PC plus: sign imm: offset abs