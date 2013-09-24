debug support
cheapAddressCouldBeInHeap: address 
	^(address bitAnd: self wordSize - 1) = 0
	  and: [address >= startOfMemory
	  and: [address <= freeOldSpaceStart]]