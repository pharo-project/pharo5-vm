snapshot
adjustAllOopsBy: bytesToShift
	"Adjust all oop references by the given number of bytes. This is
	 done just after reading in an image when the new base address
	 of the object heap is different from the base address in the image,
	 or when loading multiple segments that have been coalesced.  Also
	 set bits in the classTableBitmap corresponding to used classes."

	| obj classIndex |
	self countNumClassPagesPreSwizzle: bytesToShift;
		ensureAdequateClassTableBitmap.
	(bytesToShift ~= 0
	 or: [segmentManager numSegments > 1])
		ifTrue:
			[self assert: self newSpaceIsEmpty.
			 obj := self objectStartingAt: oldSpaceStart.
			 [self oop: obj isLessThan: freeOldSpaceStart] whileTrue:
				[classIndex := self classIndexOf: obj.
				 classIndex >= self isForwardedObjectClassIndexPun
					ifTrue:
						[classIndex > self lastClassIndexPun ifTrue:
							[self inClassTableBitmapSet: classIndex].
						 self swizzleFieldsOfObject: obj]
					ifFalse:
						[classIndex = self isFreeObjectClassIndexPun ifTrue:
							[self swizzleFieldsOfFreeChunk: obj]].
				 obj := self objectAfter: obj]]
		ifFalse:
			[self assert: self newSpaceIsEmpty.
			 obj := self objectStartingAt: oldSpaceStart.
			 [self oop: obj isLessThan: endOfMemory] whileTrue:
				[classIndex := self classIndexOf: obj.
				 classIndex > self lastClassIndexPun ifTrue:
					[self inClassTableBitmapSet: classIndex].
				 obj := self objectAfter: obj]]