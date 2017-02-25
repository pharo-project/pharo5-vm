file primitives
primitiveFileSync
	| file |
	<var: 'file' type: 'SQFile *'>
	<export: true>
	file := self fileValueOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed ifFalse:[self sqFileSync: file].
	interpreterProxy failed ifFalse: [interpreterProxy pop: 1].