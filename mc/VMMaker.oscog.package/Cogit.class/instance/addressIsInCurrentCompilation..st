testing
addressIsInCurrentCompilation: address
	^address asUnsignedInteger >= methodLabel address
	  and: [address asUnsignedInteger < methodZone youngReferrers]