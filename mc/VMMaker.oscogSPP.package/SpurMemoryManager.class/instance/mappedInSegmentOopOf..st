image segment in/out
mappedInSegmentOopOf: objOop
	"This is part of storeImageSegmentInto:outPointers:roots:.
	 objOop is an object whose hash has been set to its mapped oop in either the segment or the
	 out pointers.  If its hash's top bit is set then it is in out pointers.  Answer the mapped oop."
	<inline: true>
	| hash |
	hash := self rawHashBitsOf: objOop.
	^(hash anyMask: TopHashBit)
		ifTrue: [hash - TopHashBit * self bytesPerOop + TopOopBit]
		ifFalse: [hash * self allocationUnit]