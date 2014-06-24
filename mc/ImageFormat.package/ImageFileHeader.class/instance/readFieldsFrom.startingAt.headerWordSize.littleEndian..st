reading
readFieldsFrom: aStream startingAt: imageOffset headerWordSize: headerWordSize littleEndian: littleEndian
	"Read data fields and answer number of bytes read"

	| remainder screenSizeWord |
	headerSize := self nextNumber: headerWordSize from: aStream littleEndian: littleEndian.
	imageBytes := self nextNumber: headerWordSize from: aStream littleEndian: littleEndian.
	startOfMemory := self nextNumber: headerWordSize from: aStream littleEndian: littleEndian.
	specialObjectsOop := self nextNumber: headerWordSize from: aStream littleEndian: littleEndian.
	lastHash := self nextNumber: headerWordSize from: aStream littleEndian: littleEndian.
	screenSizeWord := self nextNumber: headerWordSize from: aStream littleEndian: littleEndian.
	screenSize := (screenSizeWord >> 16) @ (screenSizeWord bitAnd: 16rFFFF).
	imageHeaderFlags := self nextNumber: headerWordSize from: aStream littleEndian: littleEndian.
	extraVMMemory := self nextNumber: headerWordSize from: aStream littleEndian: littleEndian.
	remainder := headerSize - (9 * imageFormat wordSize).
	self assert: remainder >= 0. "n.b. Mantis 7455 bug in original 64 bit image due to VMM error"
	^9 * imageFormat wordSize.
