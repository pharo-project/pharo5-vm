memory access
shortAt: byteAddress
    "Return the half-word at byteAddress which must be even."
	| lowBits bpwMinus2 |
	bpwMinus2 := self wordSize-2.
	lowBits := byteAddress bitAnd: bpwMinus2.
	^ ((self longAt: byteAddress - lowBits)
		bitShift: (lowBits - bpwMinus2) * 8)
		bitAnd: 16rFFFF
