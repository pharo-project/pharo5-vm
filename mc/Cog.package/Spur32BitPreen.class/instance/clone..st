bootstrap image
clone: oldObj
	| newObj hash |
	newObj := newHeap
				allocateSlots: (oldHeap numSlotsOf: oldObj)
				format: (oldHeap formatOf: oldObj)
				classIndex: (oldHeap classIndexOf: oldObj).
	(hash := oldHeap rawHashBitsOf: oldObj) ~= 0 ifTrue:
		[newHeap setHashBitsOf: newObj to: hash].
	(oldHeap isImmutable: oldObj) ifTrue:
		[newHeap setIsImmutableOf: newObj to: true].
	(oldHeap isPinned: oldObj) ifTrue:
		[newHeap setIsPinnedOf: newObj to: true].
	self deny: (oldHeap isRemembered: oldObj).
	self deny: (oldHeap isMarked: oldObj).
	self deny: (oldHeap isGrey: oldObj).
	reverseMap at: newObj put: oldObj.
	^map at: oldObj put: newObj