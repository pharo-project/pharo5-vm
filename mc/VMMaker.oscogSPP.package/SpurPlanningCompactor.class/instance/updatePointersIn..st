compaction
updatePointersIn: obj
	"Sweep the pointer fields in obj, updating all references to mobile objects to their eventual locations."
	<inline: true>
	| numPointerSlots |
	numPointerSlots := manager numPointerSlotsOf: obj.
	0 to: numPointerSlots - 1 do:
		[:i| | oop fwd |
		 oop := manager fetchPointer: i ofObject: obj.
		 ((manager isNonImmediate: oop) and: [self isMobile: oop]) ifTrue:
			[self assert: ((manager isMarked: oop) or: [obj = manager hiddenRootsObject]).
			 fwd := manager fetchPointer: 0 ofObject: oop.
			 self assert: (self isPostMobile: fwd).
			 manager storePointerUnchecked: i ofObject: obj withValue: fwd]]