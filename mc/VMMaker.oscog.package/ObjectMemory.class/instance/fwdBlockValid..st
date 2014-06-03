gc -- compaction
fwdBlockValid: addr 
	"Answer if the given address is a valid forward table entry."
	^(self oop: addr isGreaterThan: endOfMemory)
	   and: [(self oop: addr isLessThanOrEqualTo: fwdTableNext)
	   and: [(addr bitAnd: 3) = 0]]