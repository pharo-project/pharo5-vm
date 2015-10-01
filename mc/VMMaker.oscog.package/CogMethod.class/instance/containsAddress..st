testing
containsAddress: anAddress
	<inline: true>
	^self asUnsignedInteger <= anAddress asUnsignedInteger
	  and: [self asUnsignedInteger + self blockSize >= anAddress asUnsignedInteger]