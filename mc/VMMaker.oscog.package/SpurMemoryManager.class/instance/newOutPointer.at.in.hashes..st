image segment in/out
newOutPointer: oop at: outIndex in: outPointerArray hashes: savedOutHashes
	"This is part of storeImageSegmentInto:outPointers:roots:.
	 oop is a new outPointer; allocate its oop, and answer the new outIndex.
	 If outPointerArray is full, answer 0."
	<inline: true>
	outIndex >= (self numSlotsOf: outPointerArray) ifTrue:
					["no room in outPointers; fail"
					 ^0].
	self storePointer: outIndex ofObject: outPointerArray withValue: oop.
	self storeLong32: outIndex ofObject: savedOutHashes withValue: (self rawHashBitsOf: oop).
	self setHashBitsOf: oop to: outIndex + TopHashBit.
	self setIsMarkedOf: oop to: true.
	^outIndex + 1