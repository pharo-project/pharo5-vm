deprecated
primitiveMakePipe
	"Create a pipe, and answer an array of two file handles for the pipe writer and reader.
	The readerIOStream and writerIOStream variables represent the low level pipe streams,
	which will be of type (FILE *) or HANDLE, depending on what the FilePlugin support
	code is using to represent file streams. FILEHANDLETYPE is defined in my subclasses
	in the #declareCVarsIn: class method."

	| reader writer readerPtr writerPtr readerIOStream writerIOStream
	readerIOStreamPtr writerIOStreamPtr thisSession arrayResult |
	<export: true>
	<var: 'readerIOStream' declareC: 'FILEHANDLETYPE readerIOStream'>
	<var: 'writerIOStream' declareC: 'FILEHANDLETYPE writerIOStream'>
	<var: 'readerIOStreamPtr' declareC: 'FILEHANDLETYPE *readerIOStreamPtr'>
	<var: 'writerIOStreamPtr' declareC: 'FILEHANDLETYPE *writerIOStreamPtr'>
	<var: 'readerPtr' declareC: 'SQFile *readerPtr'>
	<var: 'writerPtr' declareC: 'SQFile *writerPtr'>
	<var: 'arrayPtr' declareC: 'int *arrayPtr'>
	<var: 'thisSession' type: 'SESSIONIDENTIFIERTYPE'>
	thisSession := self getThisSessionIdentifier.

	"Create the anonymous OS pipe"
	self cCode: 'readerIOStreamPtr = &readerIOStream'.
	self cCode: 'writerIOStreamPtr = &writerIOStream'.
	(self makePipeForReader: readerIOStreamPtr writer: writerIOStreamPtr)
		ifFalse: [^ interpreterProxy primitiveFail].

	"Map the writer end to a SQFile data structure"
	writer := self newSQFileByteArray.
	writerPtr := self fileValueOf: writer.
	self cCode: 'writerPtr->file = writerIOStream'.
	self cCode: 'writerPtr->sessionID = thisSession'.
	self cCode: 'writerPtr->writable = 1'.
	self cCode: 'writerPtr->lastOp = 0'.
	interpreterProxy pushRemappableOop: writer.

	"Map the reader end to a SQFile data structure"
	reader := self newSQFileByteArray.
	readerPtr := self fileValueOf: reader.
	self cCode: 'readerPtr->file = readerIOStream'.	
	self cCode: 'readerPtr->sessionID = thisSession'.
	self cCode: 'readerPtr->writable = 0'.
	self cCode: 'readerPtr->lastOp = 0'.
	interpreterProxy pushRemappableOop: reader.

	"Answer an array of two SQFile pipe ends"
	arrayResult := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: 2.
	interpreterProxy stObject: arrayResult at: 1 put: interpreterProxy popRemappableOop.	"reader"
	interpreterProxy stObject: arrayResult at: 2 put: interpreterProxy popRemappableOop. "writer"
	interpreterProxy pop: 1; push: arrayResult
