writing
writeFieldsTo: aStream littleEndian: littleEnder headerWordSize: headerWordSize
	"Write data fields and answer number of bytes written"

	| bytesWritten |
	bytesWritten := super writeFieldsTo: aStream littleEndian: littleEnder headerWordSize: headerWordSize.
	self nextNumber: headerWordSize / 2 put: desiredNumStackPages to: aStream littleEndian: littleEnder.
	self nextNumber: headerWordSize / 2 put: unknownShortOrCodeSizeInKs to: aStream littleEndian: littleEnder.
	self nextNumber: headerWordSize put: desiredEdenBytes to: aStream littleEndian: littleEnder.
	self nextNumber: headerWordSize / 2 put: maxExtSemTabSizeSet to: aStream littleEndian: littleEnder.
	self nextNumber: headerWordSize / 2 put: 0 to: aStream littleEndian: littleEnder.
	^3 * imageFormat wordSize + bytesWritten.
