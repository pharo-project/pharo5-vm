writing
writeFieldsTo: aStream littleEndian: littleEnder headerWordSize: headerWordSize
	"Write data fields and answer number of bytes written"

	self nextNumber: headerWordSize put: imageFormat asInteger to: aStream littleEndian: littleEnder.
	self nextNumber: headerWordSize put: headerSize to: aStream littleEndian: littleEnder.
	self nextNumber: headerWordSize put: imageBytes to: aStream littleEndian: littleEnder.
	self nextNumber: headerWordSize put: startOfMemory to: aStream littleEndian: littleEnder.
	self nextNumber: headerWordSize put: specialObjectsOop to: aStream littleEndian: littleEnder.
	self nextNumber: headerWordSize put: lastHash to: aStream littleEndian: littleEnder.
	self nextNumber: headerWordSize put: ((screenSize x) << 16 + (screenSize y)) to: aStream littleEndian: littleEnder.
	self nextNumber: headerWordSize put: imageHeaderFlags to: aStream littleEndian: littleEnder.
	self nextNumber: headerWordSize put: extraVMMemory to: aStream littleEndian: littleEnder.
	^9 * imageFormat wordSize.
