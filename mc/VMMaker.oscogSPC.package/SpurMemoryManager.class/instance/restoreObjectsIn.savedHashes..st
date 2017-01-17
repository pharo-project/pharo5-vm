image segment in/out
restoreObjectsIn: objArray savedHashes: savedHashes
	"This is part of storeImageSegmentInto:outPointers:roots:.
	 Enumerate the objects in objArray, unmarking them and restoring their hashes
	 from the corresponding 32-bit slots in savedHashes.  The first unused entry in
	 objArray will have a non-hash value entry in savedHashes.  Free savedHashes."
	<inline: false>
	0 to: (self numSlotsOf: objArray) - 1 do:
		[:i| | hash oop |
		(hash := self fetchLong32: i ofObject: savedHashes) > self maxIdentityHash ifTrue:
			[(self isInOldSpace: savedHashes) ifTrue:
				[self freeObject: savedHashes].
			 ^self].
		oop := self fetchPointer: i ofObject: objArray.
		self setHashBitsOf: oop to: hash.
		self setIsMarkedOf: oop to: false].
	(self isInOldSpace: savedHashes) ifTrue:
		[self freeObject: savedHashes]