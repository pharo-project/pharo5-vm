image segment in/out
mapOopsFrom: segStart to: segAddr outPointers: outPointerArray outHashes: savedOutHashes
	self leakCheckImageSegments ifTrue:
		[self halt].
	^super mapOopsFrom: segStart to: segAddr outPointers: outPointerArray outHashes: savedOutHashes