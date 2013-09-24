debug support
cheapAddressCouldBeObj: address 
	^(address bitAnd: self baseHeaderSize - 1) = 0
	  and: [address >= startOfMemory
	  and: [address <= freeOldSpaceStart]]