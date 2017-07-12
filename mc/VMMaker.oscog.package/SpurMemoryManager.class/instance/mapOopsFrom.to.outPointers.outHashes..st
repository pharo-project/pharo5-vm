image segment in/out
mapOopsFrom: segStart to: segAddr outPointers: outPointerArray outHashes: savedOutHashes
	"This is part of storeImageSegmentInto:outPointers:roots:.
	 Now scan, adding out pointers to the outPointersArray; all objects in arrayOfObjects
	 have had their first fields set to point to their copies in segmentWordArray.  Answer
	 the outIndex if the scan succeded.  Fail if outPointers is too small and answer -1.

	 As established by copyObj:toAddr:startAt:stopAt:savedFirstFields:index:,
	 the marked bit is set for all objects in the segment
	 the remembered bit is set for all classes in the segment.

	 Class indices should be set as follows (see assignClassIndicesAndPinFrom:to:outPointers:filling:)
	 - class indices for classes in the segment "
	| objOop outIndex |
	outIndex := 0.
	self fillObj: outPointerArray numSlots: (self numSlotsOf: outPointerArray) with: nilObj.
	objOop := self objectStartingAt: segStart.
	[self oop: objOop isLessThan: segAddr] whileTrue:
		[| heapOop oop hash segIndex |
		 heapOop := self fetchClassOfNonImm: objOop.
		 "Set the classIndex of the instance.  This is a segment offset (segAddr - segStart / allocatiopnUnit) for instances of
		  classes within the segment, and an outPointer index (index in outPointers + TopHashBit) for classes outside the segment."
		 (self isCopiedIntoSegment: heapOop)
			ifTrue: "oop is a class in the segment; storeImageSegmentInto:outPointers:roots: established offset is within range."
				[oop := self fetchPointer: 0 ofObject: heapOop.
				 self assert: (self oop: oop isGreaterThanOrEqualTo: segStart andLessThan: segAddr).
				 segIndex := oop - segStart / self allocationUnit + self firstClassIndexPun.
				 (segIndex anyMask: TopHashBit) ifTrue: "Too many classes in the segment"
					[^-1 halt]]
			ifFalse: "oop is an outPointer; locate or allocate its oop"
				[hash := self rawHashBitsOf: heapOop.
				 (self is: hash outPointerClassHashFor: heapOop in: outPointerArray limit: outIndex)
					ifTrue: [segIndex := hash]
					ifFalse: "oop is a new outPointer; allocate its oop"
						[outIndex := self newOutPointer: heapOop at: outIndex in: outPointerArray hashes: savedOutHashes.
						 outIndex = 0 ifTrue: "no room in outPointers; fail"
							[^-1 halt].
						 segIndex := self rawHashBitsOf: heapOop].
				 self assert: (segIndex anyMask: TopHashBit)].
		 self setClassIndexOf: objOop to: segIndex.
		 0 to: (self numPointerSlotsOf: objOop) - 1 do:
			[:i|
			 heapOop := self fetchPointer: i ofObject: objOop.
			 (self isNonImmediate: heapOop) ifTrue:
				[(self isCopiedIntoSegment: heapOop)
					ifTrue: "oop is an object in the segment."
						[oop := self fetchPointer: 0 ofObject: heapOop.
						 self assert: (self oop: oop isGreaterThanOrEqualTo: segStart andLessThan: segAddr).
						 oop := oop - segStart]
					ifFalse: "oop is an outPointer; locate or allocate its oop"
						[hash := self rawHashBitsOf: heapOop.
						(self is: hash outPointerClassHashFor: heapOop in: outPointerArray limit: outIndex)
							ifTrue: [oop := hash - TopHashBit * self bytesPerOop + TopOopBit]
							ifFalse: "oop is a new outPointer; allocate its oop"
								[outIndex := self newOutPointer: heapOop at: outIndex in: outPointerArray hashes: savedOutHashes.
								 outIndex = 0 ifTrue: "no room in outPointers; fail"
									[^-1 halt].
								 self assert: ((self rawHashBitsOf: heapOop) anyMask: TopHashBit).
								 oop := (self rawHashBitsOf: heapOop) - TopHashBit * self bytesPerOop + TopOopBit]].
				 self storePointerUnchecked: i ofObject: objOop withValue: oop]].
		 objOop := self objectAfter: objOop limit: segAddr].
	^outIndex