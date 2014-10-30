image segment in/out
mapOopsAndValidateClassRefsFrom: segmentStart to: segmentLimit outPointers: outPointerArray
	"scan through mapping oops and validating class references.
	 Defer entering any class objects into the class table and/or
	 pinning objects until a second pass."
	| numOutPointers objOop topHashBit topOopBit |
	numOutPointers := self numSlotsOf: outPointerArray.
	topHashBit := 1 bitShift: self identityHashFieldWidth - 1.
	topOopBit := 1 bitShift: self bytesPerOop * 8 - 1.
	objOop := self objectStartingAt: segmentStart.
	[objOop < segmentLimit] whileTrue:
		[| classIndex hash oop mappedOop |
		 (self isMarked: objOop) ifTrue:
			[^PrimErrInappropriate].
		 classIndex := self classIndexOf: objOop.
		 "validate the class ref, but don't update it until any internal classes have been added to the class table."
		 (classIndex anyMask: topHashBit)
			ifTrue:
				[classIndex - topHashBit >= numOutPointers ifTrue:
					[^PrimErrBadIndex].
				 mappedOop := self fetchPointer: classIndex - topHashBit ofObject: outPointerArray.
				 hash := self rawHashBitsOf: mappedOop.
				 (hash > self lastClassIndexPun and: [(self classOrNilAtIndex: hash) = mappedOop]) ifFalse:
					[^PrimErrInappropriate]]
			ifFalse: "The class is contained within the segment."
				[(oop := classIndex * self allocationUnit + segmentStart) >= segmentLimit ifTrue:
					[^PrimErrBadIndex].
				 (self rawHashBitsOf: oop) ~= 0 ifTrue:
					[^PrimErrInappropriate]].
		 0 to: (self numPointerSlotsOf: objOop) - 1 do:
			[:i|
			 oop := self fetchPointer: i ofObject: objOop.
			 (self isNonImmediate: oop) ifTrue:
				[(oop anyMask: topOopBit)
					ifTrue:
						[(oop := oop - topOopBit / self bytesPerOop) >= numOutPointers ifTrue:
							[^PrimErrBadIndex].
						 mappedOop := self fetchPointer: oop ofObject: outPointerArray]
					ifFalse:
						[(oop bitAnd: self allocationUnit - 1) ~= 0 ifTrue:
							[^PrimErrInappropriate].
						 (mappedOop := oop + segmentStart) >= segmentLimit ifTrue:
							[^PrimErrBadIndex]].
				 self storePointerUnchecked: i ofObject: objOop withValue: mappedOop]].
		 objOop := self objectAfter: objOop limit: segmentLimit].
	^0