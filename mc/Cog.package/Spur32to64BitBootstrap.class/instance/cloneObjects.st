bootstrap image
cloneObjects
	"Clone all normal objects.  Of hidden objects only clone the freeLists object and
	 the classTableRoot and class table pages. In particular, dont clone objStacks.
	 The refs to the objStacks are nilled out in fillInHeap."
	| i freeListsObject |
	i := 0.
	freeListsObject := heap32 freeListsObject.
	heap32 allOldSpaceObjectsDo:
		[:obj32|
		(i := i + 1) >= 100000 ifTrue:
			[Transcript nextPut: $:; flush. i := 0].
		 obj32 = freeListsObject
			ifTrue:
				[self cloneFreeLists: obj32]
			ifFalse:
				[(self shouldClone: obj32) ifTrue:
					[self clone: obj32]]]