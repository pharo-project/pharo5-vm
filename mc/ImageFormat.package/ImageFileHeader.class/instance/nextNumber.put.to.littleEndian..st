writing
nextNumber: n put: v to: aStream littleEndian: littleEnder

	littleEnder
		ifTrue: [^aStream nextLittleEndianNumber: n put: v]
		ifFalse: [^aStream nextNumber: n put: v]