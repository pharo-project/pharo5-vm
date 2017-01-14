memory access
shortAt: byteAddress put: a16BitValue
    "Return the half-word at byteAddress which must be even."
	| lowBits long longAddress |
	lowBits := byteAddress bitAnd: 2.
	lowBits = 0
		ifTrue:
		[ "storing into LS word"
		long := self longAt: byteAddress.
		self longAt: byteAddress
				put: ((long bitAnd: 16rFFFF0000) bitOr: a16BitValue)
		]
		ifFalse:
		[longAddress := byteAddress - 2.
		long := self longAt: longAddress.
		self longAt: longAddress
				put: ((long bitAnd: 16rFFFF) bitOr: (a16BitValue bitShift: 16))
		]