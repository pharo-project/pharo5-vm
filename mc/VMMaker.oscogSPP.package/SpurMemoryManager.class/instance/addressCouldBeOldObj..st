debug support
addressCouldBeOldObj: address
	^(address bitAnd: self baseHeaderSize - 1) = 0
	  and: [self isInOldSpace: address]