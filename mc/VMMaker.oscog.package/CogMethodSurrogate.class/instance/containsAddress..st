testing
containsAddress: anAddress
	^address <= anAddress asUnsignedInteger
	  and: [address + self blockSize >= anAddress asUnsignedInteger]