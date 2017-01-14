simulation support
netAddressAsByteArrayFromInt: netAddress
	^ByteArray
		with: ((netAddress bitShift: -24) bitAnd: 16rFF)
		with: ((netAddress bitShift: -16) bitAnd: 16rFF)
		with: ((netAddress bitShift: -8) bitAnd: 16rFF)
		with:  (netAddress bitAnd: 16rFF)