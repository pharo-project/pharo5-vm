compaction
updatePointersFrom: start to: finish in: obj
	<inline: true>
	start to: finish do:
		[:i| | oop fwd |
		 oop := manager fetchPointer: i ofObject: obj.
		 ((manager isNonImmediate: oop) and: [self isMobile: oop]) ifTrue:
			[self assert: (manager isMarked: oop).
			 fwd := manager fetchPointer: 0 ofObject: oop.
			 self assert: (self isPostMobile: fwd).
			 manager storePointerUnchecked: i ofObject: obj withValue: fwd]]