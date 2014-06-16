writing
writeTo: aStream littleEndian: littleEnder

	| headerWordSize remainder bytesWritten |
	headerWordSize := imageFormat wordSize.
	bytesWritten := self writeFieldsTo: aStream littleEndian: littleEnder headerWordSize: headerWordSize.
	remainder := headerSize - bytesWritten.
	self assert: remainder >= 0. "n.b. Mantis 7455 bug in original 64 bit image due to VMM error"
	remainder timesRepeat: [aStream nextPut: 0].
