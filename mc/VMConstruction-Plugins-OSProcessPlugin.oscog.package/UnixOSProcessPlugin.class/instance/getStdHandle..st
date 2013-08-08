private - file handles
getStdHandle: n
	"Answer the standard i/o file handle with the given index of my OS process.
	 0 = stdin, 1 = stdout, 2 = stderr."

	| validMask fileRecords fileOop |
	<var: 'fileRecords' declareC: 'SQFile fileRecords[3]'>
	self cCode: ''
		inSmalltalk:
			["In the simulator file handles are integer indexes of FilePluginSimulator's openFiles dictionary."
			^interpreterProxy pop: 1 thenPush: (interpreterProxy integerObjectOf: n)].
	validMask := self sqFileStdioHandlesInto: fileRecords.
	(validMask bitAnd: (1 << n)) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrUnsupported].

	fileOop := self newSQFileByteArray.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoMemory].

	self mem: (interpreterProxy firstIndexableField: fileOop)
		cp: (self cCode: '&fileRecords[n]')
		y: self fileRecordSize.
	^interpreterProxy pop: 1 thenPush: fileOop