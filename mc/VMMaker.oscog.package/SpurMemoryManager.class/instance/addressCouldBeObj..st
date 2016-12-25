debug support
addressCouldBeObj: address
	<api>
	<inline: false>
	^(address bitAnd: self baseHeaderSize - 1) = 0
	  and: [(self isInOldSpace: address)
		or: [(self isInEden: address)
		or: [(self isInPastSpace: address)
		or: [self scavengeInProgress and: [self isInFutureSpace: address]]]]]