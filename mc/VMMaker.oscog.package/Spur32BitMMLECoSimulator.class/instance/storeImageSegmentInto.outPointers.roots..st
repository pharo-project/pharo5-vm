image segment in/out
storeImageSegmentInto: segmentWordArray outPointers: outPointerArray roots: arrayOfRoots
	self leakCheckImageSegments ifTrue:
		[parent ifNil:
			[| result |
			 self halt.
			 result := coInterpreter cloneSimulation objectMemory storeImageSegmentInto: segmentWordArray outPointers: outPointerArray roots: arrayOfRoots.
			 Smalltalk garbageCollect]].
	^super storeImageSegmentInto: segmentWordArray outPointers: outPointerArray roots: arrayOfRoots