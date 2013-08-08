api
scavengeFutureSurvivorSpaceStartingAt: initialAddress
	"scavengeFutureSurvivorSpaceStartingAt: does a depth-first traversal of the
	 new objects starting at the one at the nth word of futureSurvivorSpace."
	| ptr |
	<var: #ptr type: #'char *'>
	ptr := initialAddress.
	[ptr < futureSpace limit] whileTrue:
		[| obj |
		 obj := manager objectAt: ptr.
		 ptr := ptr + (manager byteLengthOf: obj).
		 self cCoerceSimple: (self scavengeReferentsOf: obj)
			to: #void]