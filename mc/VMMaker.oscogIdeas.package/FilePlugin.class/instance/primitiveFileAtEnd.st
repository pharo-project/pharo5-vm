file primitives
primitiveFileAtEnd
	| file atEnd |
	<export: true>
	<var: 'file' type: 'SQFile *'>
	file := self fileValueOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed
		ifFalse: [atEnd := self sqFileAtEnd: file].
	interpreterProxy failed
		ifFalse: [interpreterProxy pop: 2. "rcvr, file"
			interpreterProxy pushBool: atEnd]