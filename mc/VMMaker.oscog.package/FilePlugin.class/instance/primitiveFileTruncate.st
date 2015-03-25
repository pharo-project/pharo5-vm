file primitives
primitiveFileTruncate
"ftruncate is not an ansi function so we have a macro to point to a suitable platform implementation" 
	| truncatePosition file |
	<var: 'file' type: #'SQFile *'>
	<var: 'truncatePosition' type: #squeakFileOffsetType>
	<export: true>
	(interpreterProxy isIntegerObject: (interpreterProxy stackValue: 0)) ifFalse:
		[(interpreterProxy byteSizeOf: (interpreterProxy stackValue: 0)) > (self sizeof: #squeakFileOffsetType) ifTrue:
			[^interpreterProxy primitiveFail]].
	truncatePosition := interpreterProxy positive64BitValueOf: (interpreterProxy stackValue: 0).
	file := self fileValueOf: (interpreterProxy stackValue: 1).
	interpreterProxy failed ifFalse:
		[self sqFile: file Truncate: truncatePosition].
		 interpreterProxy failed ifFalse:
			[interpreterProxy pop: 2 "pop position, file; leave rcvr on stack"]