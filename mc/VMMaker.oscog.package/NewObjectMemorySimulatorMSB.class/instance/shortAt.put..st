memory access
shortAt: byteAddress put: a16BitValue
    "Return the half-word at byteAddress which must be even."
	| longWord shift lowBits bpwMinus2 longAddress |
	bpwMinus2 := self wordSize-2.
	lowBits := byteAddress bitAnd: bpwMinus2.
	longAddress := byteAddress - lowBits.
	longWord := self longAt: longAddress.
	shift := (bpwMinus2 - lowBits) * 8.
	longWord := longWord
				- (longWord bitAnd: (16rFFFF bitShift: shift))
				+ (a16BitValue bitShift: shift).
	self longAt: longAddress put: longWord
