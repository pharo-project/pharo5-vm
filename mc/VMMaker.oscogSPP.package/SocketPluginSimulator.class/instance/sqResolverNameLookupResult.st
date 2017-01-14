simulation
sqResolverNameLookupResult
	"For now don't simulate the implicit semaphore."
	| bytes |
	bytes := NetNameResolver primNameLookupResult.
	self assert: bytes size = 4.
	"Effectively netAddressToInt: bytes"
	^	((bytes at: 4)) +
		((bytes at: 3) <<8) +
		((bytes at: 2) <<16) +
		((bytes at: 1) <<24)