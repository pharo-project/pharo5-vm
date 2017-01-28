garbage collection
couldBeDerivedObject: bodyAddress
	^self oop: bodyAddress - objectMemory baseHeaderSize isGreaterThanOrEqualTo: objectMemory startOfMemory