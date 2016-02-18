private - SQFile access
isNonNullSQFile: objectPointer
	"Check for the common failure mode of a SQFile record with all zeros."

	| idx sqFileBytes  |
	<var: 'sqFileBytes' type: #'unsigned char *'>
	<var: 'idx' type: #unsigned>
	sqFileBytes := interpreterProxy arrayValueOf: objectPointer.
	idx := 0.
	[idx < self fileRecordSize]
		whileTrue:
			[(sqFileBytes at: idx) ~= 0 ifTrue: [^ true].
			idx := idx + 1].
	^ false
