testing
addressIsInCurrentCompilation: address
	^address asUnsignedInteger >= methodLabel address
	  and: [address < (methodLabel address + (1 << 16))]