file primitives
primitiveFileSetPosition
	| newPosition file |
	<var: 'file' type: 'SQFile *'>
	<var: 'newPosition' type: 'squeakFileOffsetType'>
	<export: true>
	(interpreterProxy isIntegerObject: (interpreterProxy stackValue: 0)) ifFalse:
		[(interpreterProxy byteSizeOf: (interpreterProxy stackValue: 0)) ~= (self sizeof: #squeakFileOffsetType) ifTrue:
			[^interpreterProxy primitiveFail]].
	newPosition := interpreterProxy positive64BitValueOf: (interpreterProxy stackValue: 0).
	file := self fileValueOf: (interpreterProxy stackValue: 1).
	interpreterProxy failed ifFalse:
		[self sqFile: file SetPosition: newPosition ].
	interpreterProxy failed ifFalse:
		[interpreterProxy pop: 2] "pop position, file; leave rcvr on stack"