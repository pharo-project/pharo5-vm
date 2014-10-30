image segment in/out
loadImageSegmentFrom: segmentWordArray outPointers: outPointerArray
	self leakCheckImageSegments ifTrue:
		[self halt].
	^super loadImageSegmentFrom: segmentWordArray outPointers: outPointerArray