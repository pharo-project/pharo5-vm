image segment in/out
ensureNoNewObjectsIn: outPointerArray
	"This is part of loadImageSegmentFrom:outPointers:.
	 Since the reembered bit is currently used to identify classes in the segment, setting remembered bits
	 in new objects in the segment is difficult.  Instead simply arrange that there are no new objects in
	 outPointerArray, obviating the need to remember any of the loaded objects in the segment."
	| scanClassTable |
	(self isRemembered: outPointerArray) ifFalse: [^0].
	scanClassTable := false.
	0 to: (self numSlotsOf: outPointerArray) - 1 do:
		[:i| | oop clone hash |
		 oop := self fetchPointer: i ofObject: outPointerArray.
		 (self isYoung: oop) ifTrue:
			[clone := self cloneInOldSpace: oop forPinning: false.
			 clone = 0 ifTrue:
				[^PrimErrNoMemory halt].
			 ((hash := self rawHashBitsOf: oop) ~= 0
			  and: [(self classOrNilAtIndex: hash) = oop]) ifTrue:
				[scanClassTable := true].
			 self forward: oop to: clone.
			 self storePointerUnchecked: i ofObject: outPointerArray withValue: clone]].
	scavenger forgetObject: outPointerArray.
	scanClassTable ifTrue:
		[self postBecomeScanClassTable: BecamePointerObjectFlag].
	^0