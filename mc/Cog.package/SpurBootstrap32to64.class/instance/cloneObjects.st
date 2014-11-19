bootstrap image
cloneObjects
	"Clone all normal objects.  Of hidden objects only clone the freeLists object and
	 the classTableRoot and class table pages. In particular, dont clone objStacks.
	 The refs to the objStacks are nilled out in fillInHeap."
	| freeListsObject |
	freeListsObject := heap32 freeListsObject.
	heap32 allOldSpaceObjectsDo:
		[:obj32| | classIndex value |
		classIndex := heap32 classIndexOf: obj32.
		obj32 = freeListsObject
			ifTrue:
				[self cloneFreeLists: obj32]
			ifFalse:
				[(heap32 isValidObjStackPage: obj32) ifFalse:
					[((classIndex between: ClassLargeNegativeIntegerCompactIndex and: ClassLargePositiveIntegerCompactIndex)
					  and: [interpreter32 initPrimCall.
						value := heap32 positive64BitValueOf: obj32.
						interpreter32 failed not
					  and: [heap64 isIntegerValue: value]]) ifFalse:
						[self clone: obj32]]]]