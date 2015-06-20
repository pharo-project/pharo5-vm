testing
containsAddress: address
	<inline: true>
	^self asUnsignedInteger <= address asUnsignedInteger
	  and: [self asUnsignedInteger + self blockSize >= address asUnsignedInteger]