image segment in/out
storeImageSegmentInto: segmentWordArray outPointers: outPointerArray roots: arrayOfRoots
	self leakCheckImageSegments ifTrue:
		[self halt].
	^super storeImageSegmentInto: segmentWordArray outPointers: outPointerArray roots: arrayOfRoots