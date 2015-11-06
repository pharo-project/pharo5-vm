testing
containsAddress: anAddress
	"is anAddress within my bounds; not a test of addresses referred to within instructions in the method"
	<inline: true>
	^self asUnsignedInteger <= anAddress asUnsignedInteger
	  and: [self asUnsignedInteger + self blockSize >= anAddress asUnsignedInteger]