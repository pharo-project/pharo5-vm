file primitives
primitiveFileClose

	| file |
	<export: true>
	<var: 'file' type: 'SQFile *'>
	file := self fileValueOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed ifFalse: [ self sqFileClose: file ].
	interpreterProxy failed ifFalse: [ interpreterProxy pop: 1  "pop file; leave rcvr on stack" ].