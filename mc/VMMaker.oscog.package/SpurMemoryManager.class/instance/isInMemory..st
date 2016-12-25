plugin support
isInMemory: address 
	"Answer if the given address is in ST object memory."
	(self isInNewSpace: address) ifTrue:
		[^(self isInEden: address)
			or: [(self isInPastSpace: address)
			or: [self scavengeInProgress and: [self isInFutureSpace: address]]]].
	^segmentManager isInSegments: address