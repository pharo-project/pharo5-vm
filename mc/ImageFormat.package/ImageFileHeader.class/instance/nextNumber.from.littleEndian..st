reading
nextNumber: length from: aStream littleEndian: littleEnder

	littleEnder
		ifTrue: [^aStream nextLittleEndianNumber: length]
		ifFalse: [^aStream nextNumber: length]