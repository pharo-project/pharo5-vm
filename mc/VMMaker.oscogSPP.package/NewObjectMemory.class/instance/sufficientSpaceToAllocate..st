allocation
sufficientSpaceToAllocate: bytes
	"Return true if there is enough space to allocate the given number of bytes, perhaps after doing a garbage collection."

	| minFree |
	<inline: true>
	minFree := (lowSpaceThreshold + bytes + self baseHeaderSize + self wordSize - 1) bitClear: self wordSize - 1.

	"check for low-space"
	(self oop: freeStart + minFree isLessThanOrEqualTo: reserveStart) ifTrue:
		[^true].
	^self sufficientSpaceAfterGC: minFree