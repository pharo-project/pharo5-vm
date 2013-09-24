debug support
addressCouldBeObj: address
	self flag: #temporary. "include futureSpace for now (while debugging the scavenger)"
	^(address bitAnd: self baseHeaderSize - 1) = 0
	  and: [(self isInOldSpace: address)
		or: (self isInEden: address)
		or: [(self isInSurvivorSpace: address)
		or: [scavengeInProgress and: [self isInFutureSpace: address]]]]