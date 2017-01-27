snapshot
adjustAllOopsBy: bytesToShift
	"Adjust all oop references by the given number of bytes. This is
	 done just after reading in an image when the new base address
	 of the object heap is different from the base address in the image,
	 or when loading multiple segments that have been coalesced.  Also
	 set bits in the classTableBitmap corresponding to used classes."

	| obj classIndex |
	self assert: self newSpaceIsEmpty.
	self countNumClassPagesPreSwizzle: bytesToShift.
	(bytesToShift ~= 0
	 or: [segmentManager numSegments > 1]) ifTrue:
		[obj := self objectStartingAt: oldSpaceStart.
		 [self oop: obj isLessThan: freeOldSpaceStart] whileTrue:
			[classIndex := self classIndexOf: obj.
			 classIndex >= self isForwardedObjectClassIndexPun
				ifTrue:
					[self swizzleFieldsOfObject: obj]
				ifFalse:
					[classIndex = self isFreeObjectClassIndexPun ifTrue:
						[self swizzleFieldsOfFreeChunk: obj]].
			 obj := self objectAfter: obj]]