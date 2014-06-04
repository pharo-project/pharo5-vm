allocation
sufficientSpaceToAllocate: bytes
	"Return true if there is enough space to allocate the given number of bytes, perhaps after doing a garbage collection."

	| minFree |
	<inline: true>
	minFree := (lowSpaceThreshold + bytes + BaseHeaderSize + BytesPerWord - 1) bitClear: BytesPerWord - 1.

	"check for low-space"
	(self oop: (self sizeOfFree: freeBlock) isGreaterThanOrEqualTo: minFree)
		ifTrue: [^true]
		ifFalse: [^self sufficientSpaceAfterGC: minFree].