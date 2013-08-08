private - SQSocket access
isNullSQSocket: objectPointer
	"Check for the common failure mode of a SQSocket record with all zeros."

	| idx sqSocketBytes |
	<var: 'sqSocketBytes' type: 'unsigned char *'>
	sqSocketBytes := interpreterProxy arrayValueOf: objectPointer.
	idx := 0.
	[idx < self socketRecordSize]
		whileTrue:
			[((sqSocketBytes at: idx) ~= 0) ifTrue: [^ false].
			idx := idx + 1].
	^ true
