testing
addressIsInCodeZone: address
	<inline: true>
	^address asUnsignedInteger >= codeBase
	  and: [address < methodZone zoneEnd]