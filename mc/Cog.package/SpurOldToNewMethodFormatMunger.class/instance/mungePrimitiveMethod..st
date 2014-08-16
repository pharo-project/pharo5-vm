munging
mungePrimitiveMethod: obj
	| numBytes copy firstByteIndex primIndex numPointerSlots header |
	numBytes := heap byteSizeOf: obj.
	copy := heap allocateSlotsInOldSpace: (heap numSlotsForBytes: numBytes + 3)
				format: (heap compiledMethodFormatForNumBytes: numBytes + 3)
				classIndex: (heap classIndexOf: obj).
	header := heap methodHeaderOf: obj.
	numPointerSlots := (heap literalCountOfMethodHeader: header) + LiteralStart.
	heap
		storePointerUnchecked: 0
		ofObject: copy
		withValue: (self convertOldMethodHeader: header).
	1 to: numPointerSlots - 1 do:
		[:i|
		heap storePointer: i
			ofObject: copy
			withValue: (heap fetchPointer: i ofObject: obj)].
	primIndex := heap primitiveIndexOfMethodHeader: header.
	firstByteIndex := numPointerSlots * heap bytesPerOop.
	heap
		storeByte: firstByteIndex + 0 ofObject: copy withValue: 139;
		storeByte: firstByteIndex + 1 ofObject: copy withValue: (primIndex bitAnd: 255);
		storeByte: firstByteIndex + 2 ofObject: copy withValue: (primIndex bitShift: -8).
	firstByteIndex to: numBytes - 1 do:
		[:i|
		heap storeByte: i + 3 ofObject: copy withValue: (heap fetchByte: i ofObject: obj)].
	heap forward: obj to: copy.
	^copy