image segment in/out
mapOopsAndValidateClassRefsFrom: segmentStart to: segmentLimit outPointers: outPointerArray
	"This is part of loadImageSegmentFrom:outPointers:.
	 Scan through mapping oops and validating class references.  Defer
	 entering any class objects into the class table and/or pinning objects
	 until the second pass in assignClassIndicesAndPinFrom:to:outPointers:."
	<var: 'segmentLimit' type: #usqInt>
	| numOutPointers numSegObjs objOop |
	<var: #oop type: #usqInt>
	numOutPointers := self numSlotsOf: outPointerArray.
	numSegObjs := 0.
	objOop := self objectStartingAt: segmentStart.
	[self oop: objOop isLessThan: segmentLimit] whileTrue:
		[| classIndex hash oop mappedOop |
		 numSegObjs := numSegObjs + 1.
		 "No object in the segment should be marked.  If is is something is wrong."
		 (self isMarked: objOop) ifTrue:
			[^PrimErrInappropriate].
		 classIndex := self classIndexOf: objOop.
		 "validate the class ref, but don't update it until any internal classes have been added to the class table."
		 (classIndex anyMask: TopHashBit)
			ifTrue:
				[classIndex := classIndex - TopHashBit.
				 classIndex >= numOutPointers ifTrue:
					[^PrimErrBadIndex halt].
				 mappedOop := self fetchPointer: classIndex ofObject: outPointerArray.
				 hash := self rawHashBitsOf: mappedOop.
				 (hash > self lastClassIndexPun and: [(self classOrNilAtIndex: hash) = mappedOop]) ifFalse:
					[^PrimErrInappropriate halt]]
			ifFalse: "The class is contained within the segment."
				[(oop := classIndex - self firstClassIndexPun * self allocationUnit + segmentStart) >= segmentLimit ifTrue:
					[^PrimErrBadIndex halt].
				 (self rawHashBitsOf: oop) ~= 0 ifTrue:
					[^PrimErrInappropriate halt]].
		 0 to: (self numPointerSlotsOf: objOop) - 1 do:
			[:i|
			 oop := self fetchPointer: i ofObject: objOop.
			 (self isNonImmediate: oop) ifTrue:
				[(oop anyMask: TopOopBit)
					ifTrue:
						[(oop := oop - TopOopBit / self bytesPerOop) >= numOutPointers ifTrue:
							[^PrimErrBadIndex halt].
						 mappedOop := self fetchPointer: oop ofObject: outPointerArray]
					ifFalse:
						[(oop bitAnd: self allocationUnit - 1) ~= 0 ifTrue:
							[^PrimErrInappropriate halt].
						 (mappedOop := oop + segmentStart) >= segmentLimit ifTrue:
							[^PrimErrBadIndex halt]].
				 self storePointerUnchecked: i ofObject: objOop withValue: mappedOop]].
		 objOop := self objectAfter: objOop limit: segmentLimit].
	^numSegObjs negated