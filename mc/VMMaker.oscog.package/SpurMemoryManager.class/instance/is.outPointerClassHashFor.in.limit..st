image segment in/out
is: hash outPointerClassHashFor: oop in: outPointerArray limit: outIndex
	"This is part of storeImageSegmentInto:outPointers:roots:.
	 suspect; what about false positives?"
	^(hash anyMask: TopHashBit)
	  and: [hash - TopHashBit <= outIndex
	  and: [oop = (self fetchPointer: hash - TopHashBit ofObject: outPointerArray)]]