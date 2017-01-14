testing
addressIsInCurrentCompilation: address
	<inline: true>
	^address asUnsignedInteger >= methodLabel address
	  and: [address asUnsignedInteger < methodZone youngReferrers]