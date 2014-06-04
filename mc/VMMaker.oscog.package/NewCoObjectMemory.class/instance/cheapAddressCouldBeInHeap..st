debug support
cheapAddressCouldBeInHeap: address 
	^(address bitAnd: self wordSize - 1) = 0
	  and: [(self oop: address isGreaterThanOrEqualTo: self startOfMemory)
	  and: [self oop: address isLessThan: freeStart]]