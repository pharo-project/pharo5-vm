printing
printOn: aStream
	<doNotGenerate>
	super printOn: aStream.
	aStream nextPut: $@; print: baseAddress; space.
	self isFree
		ifTrue: [aStream nextPutAll: 'free']
		ifFalse: [aStream print: baseFP; nextPutAll: '<->'; print: headFP; space; nextPutAll: 'trace '; print: trace]