allocating
allocate: numBytes
	| roundedBytes allocation |
	roundedBytes := numBytes + 7 bitAnd: -8.
	mzFreeStart + roundedBytes >= (limitAddress - (methodCount * BytesPerWord)) ifTrue:
		[^0].
	allocation := mzFreeStart.
	mzFreeStart := mzFreeStart + roundedBytes.
	methodCount := methodCount + 1.
	self assert: self roomOnYoungReferrersList.
	self cCode: '' inSmalltalk:
		[(cogit breakPC isInteger
		   and: [cogit breakPC between: allocation and: mzFreeStart]) ifTrue:
			[cogit singleStep: true]].
	^allocation