reading
readFrom: aStream startingAt: imageOffset

	| remainder bytesRead headerWordSize littleEndian |
	littleEndian := self readImageVersionFrom: aStream startingAt: imageOffset.
	headerWordSize := aStream position - imageOffset.
	bytesRead := self readFieldsFrom: aStream startingAt: imageOffset headerWordSize: headerWordSize littleEndian: littleEndian.
	remainder := headerSize - bytesRead.
	self assert: remainder >= 0. "n.b. Mantis 7455 bug in original 64 bit image due to VMM error"
	aStream next: (headerSize - bytesRead).
