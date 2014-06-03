scavenger
scavengeFutureSurvivorSpaceStartingAt: initialAddress
	"scavengeFutureSurvivorSpaceStartingAt: does a depth-first traversal of the
	 new objects starting at the one at initialAddress in futureSurvivorSpace."
	<inline: false>
	| ptr obj |
	ptr := initialAddress.
	[ptr < futureSurvivorStart] whileTrue:
		[obj := manager objectStartingAt: ptr.
		 ptr := manager addressAfter: obj.
		 self cCoerceSimple: (self scavengeReferentsOf: obj) to: #void]