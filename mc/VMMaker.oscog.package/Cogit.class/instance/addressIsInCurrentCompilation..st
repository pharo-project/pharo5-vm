testing
addressIsInCurrentCompilation: address
	^address asUnsignedInteger >= methodLabel address
	  and: [address asUnsignedInteger < (methodLabel address + (1 << 16))]