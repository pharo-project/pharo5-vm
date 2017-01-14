memory access
long32At: byteAddress put: a32BitValue
 	"Store the 32-bit word at byteAddress which must be a multiple of four."
	| lowBits long longAddress |
	lowBits := byteAddress bitAnd: 4.
	lowBits = 0
		ifTrue: "storing into LS word"
			[long := self long64At: byteAddress.
			 self long64At: byteAddress
				put: ((long bitAnd: 16rFFFFFFFF00000000) bitOr: a32BitValue)]
		ifFalse: "storing into MS word"
			[longAddress := byteAddress - 4.
			long := self long64At: longAddress.
			self long64At: longAddress
				put: ((long bitAnd: 16rFFFFFFFF) bitOr: (a32BitValue bitShift: 32))].
	^a32BitValue