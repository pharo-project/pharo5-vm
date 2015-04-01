testing
isAddressRelativeToPC: pcAddress
	"Support for addressing the method relative to the PC."
	^pcAddress notNil
	  and: [pcAddress <= address
	  and: [address - pcAddress < (1 << 12)]]