image segment in/out
mappedOopOf: objOop topHashBit: topHashBit topOopBit: topOopBit
	"objOop is an object whose hash has been set to its mapped oop in either the segment or the
	 out pointers.  If its hash's top bit is set then it is in out pointers.  Answer the mapped oop."
	<inline: true>
	| hash |
	hash := self rawHashBitsOf: objOop.
	^(hash anyMask: topHashBit)
		ifTrue: [hash - topHashBit * self bytesPerOop + topOopBit]
		ifFalse: [hash * self allocationUnit]