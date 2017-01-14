compaction
relocateObjectsInHeapEntity: heapEntity from: startIndex to: finishIndex
	"Sweep the fields in some non-pointer heap entity (objStackPage, rememberedSet),
	 updating all references to mobile objects to their eventual locations.  Answer the
	 heapEntity's eventual location."
	<inline: true>
	startIndex to: finishIndex do:
		[:i| | oop fwd |
		 oop := manager fetchPointer: i ofObject: heapEntity.
		 ((manager isNonImmediate: oop) and: [self isMobile: oop]) ifTrue:
			[self assert: (manager isMarked: oop).
			 fwd := manager fetchPointer: 0 ofObject: oop.
			 self assert: (self isPostMobile: fwd).
			 manager storePointerUnchecked: i ofObject: heapEntity withValue: fwd]].
	^(self isMobile: heapEntity)
		ifTrue: [manager fetchPointer: 0 ofObject: heapEntity]
		ifFalse: [heapEntity]