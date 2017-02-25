debug support
addressCouldBeObj: address
	^(address bitAnd: 3) = 0
	  and: [self addressCouldBeOop: address]