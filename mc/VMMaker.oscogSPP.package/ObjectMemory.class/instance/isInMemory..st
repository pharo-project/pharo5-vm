plugin support
isInMemory: address 
	"Return true if the given address is in ST object memory"
	^ (self oop: address isGreaterThanOrEqualTo: self startOfMemory)
		and: [self oop: address isLessThan: endOfMemory]