compaction
updatePointersIn: obj startingAt: startIndex savedFirstFieldPointer: firstFieldPtrOrNil
	"Sweep the pointer fields in obj, updating all references to mobile objects to their eventual locations.
	 firstFieldPtrOrNil is supplied for mobile objects so that the first field of a compiled method (which is
	 its header, or reference to a CogMethod holding its header) can be retrieved."
	<inline: true>
	startIndex to: (self numPointerSlotsWhileCompactingOf: obj savedFirstFieldPointer: firstFieldPtrOrNil) - 1 do:
		[:i| | oop fwd |
		 oop := manager fetchPointer: i ofObject: obj.
		 ((manager isNonImmediate: oop) and: [self isMobile: oop]) ifTrue:
			[self assert: ((manager isMarked: oop) or: [obj = manager hiddenRootsObject]).
			 fwd := manager fetchPointer: 0 ofObject: oop.
			 self assert: (self isPostMobile: fwd).
			 manager storePointerUnchecked: i ofObject: obj withValue: fwd]]