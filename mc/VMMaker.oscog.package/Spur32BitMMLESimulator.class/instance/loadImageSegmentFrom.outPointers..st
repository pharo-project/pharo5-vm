image segment in/out
loadImageSegmentFrom: segmentWordArray outPointers: outPointerArray
	self leakCheckImageSegments ifTrue:
		[parent ifNil:
			[| result |
			 self halt.
			 result := coInterpreter cloneSimulation objectMemory loadImageSegmentFrom: segmentWordArray outPointers: outPointerArray.
			 Smalltalk garbageCollect]].
	^super loadImageSegmentFrom: segmentWordArray outPointers: outPointerArray