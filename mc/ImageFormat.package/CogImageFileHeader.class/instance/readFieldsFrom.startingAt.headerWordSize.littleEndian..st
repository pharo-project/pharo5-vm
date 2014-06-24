reading
readFieldsFrom: aStream startingAt: imageOffset headerWordSize: headerWordSize littleEndian: littleEndian
	"Read data fields and answer number of bytes read"

	| remainder bytesRead |
	bytesRead := super readFieldsFrom: aStream startingAt: imageOffset headerWordSize: headerWordSize littleEndian: littleEndian.
	desiredNumStackPages := self nextNumber: headerWordSize / 2 from: aStream littleEndian: littleEndian.
	unknownShortOrCodeSizeInKs := self nextNumber: headerWordSize / 2 from: aStream littleEndian: littleEndian.
	desiredEdenBytes := self nextNumber: headerWordSize from: aStream littleEndian: littleEndian.
	maxExtSemTabSizeSet := self nextNumber: headerWordSize / 2 from: aStream littleEndian: littleEndian.
	self nextNumber: headerWordSize / 2 from: aStream littleEndian: littleEndian.
	remainder := headerSize - (12 * imageFormat wordSize).
	self assert: remainder >= 0. "n.b. Mantis 7455 bug in original 64 bit image due to VMM error"
	^3 * imageFormat wordSize + bytesRead.
