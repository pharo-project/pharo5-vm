debug support
cheapAddressCouldBeInHeap: address 
	^(address bitAnd: self wordSize - 1) = 0
	  and: [(self oop: address isGreaterThanOrEqualTo: newSpaceStart)
	  and: [self oop: address isLessThan: endOfMemory]]