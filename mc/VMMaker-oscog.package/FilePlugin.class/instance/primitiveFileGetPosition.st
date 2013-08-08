file primitives
primitiveFileGetPosition
	| file position |
	<var: 'file' type: 'SQFile *'>
	<var: 'position' type: 'squeakFileOffsetType'>
	<export: true>
	file := self fileValueOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed ifFalse: [position := self sqFileGetPosition: file].
	interpreterProxy failed ifFalse: [
		interpreterProxy pop: 2 thenPush: (interpreterProxy positive64BitIntegerFor: position)].