memory access
long32At: byteAddress put: a32BitValue
	"Store the 32-bit value at byteAddress which must be 0 mod 4."
	| lowBits long64 longAddress |
	lowBits := byteAddress bitAnd: 4.
	lowBits = 0
		ifTrue:
		[ "storing into LS word"
		long64 := self longAt: byteAddress.
		self longAt: byteAddress
				put: ((long64 bitAnd: 16rFFFFFFFF00000000) bitOr: a32BitValue)
		]
		ifFalse:
		[longAddress := byteAddress - 4.
		long64 := self longAt: longAddress.
		self longAt: longAddress
				put: ((long64 bitAnd: 16rFFFFFFFF) bitOr: (a32BitValue bitShift: 32))
		]