file primitives
primitiveFileSize
	| file size |
	<var: 'file' type: 'SQFile *'>
	<var: 'size' type: 'squeakFileOffsetType'>
	<export: true>
	file := self fileValueOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed ifFalse:[size := self sqFileSize: file].
	interpreterProxy failed ifFalse: [
		interpreterProxy pop: 2 thenPush: (interpreterProxy positive64BitIntegerFor: size)].