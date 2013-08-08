primitives - files
primitiveGetStdInput
	"Answer a two element array containing the sqFile data structure representing
	standard input stream for my OS process, and a flag (true or false) to indicate
	whether the sqFile data structure contains a valid HANDLE. If no standard input
	stream is available for this OS process, the sqFile data structure will contain an
	invalid HANDLE value, which will result in failures on subsequent accesses."

	| file handle result invalid thisSession fileOop |
	<export: true>
	<var: 'file' type: 'SQFile *'>
	<var: 'handle' type: 'HANDLE'>
	<var: 'invalid' type: 'HANDLE'>
	thisSession := self sessionIdentifierFrom: (interpreterProxy stackObjectValue: 0).
	invalid := self cCode: 'INVALID_HANDLE_VALUE' inSmalltalk: [-1].
	result := interpreterProxy
		instantiateClass: interpreterProxy classArray
		indexableSize: 2.
	fileOop := self newSQFileByteArray.
	file := self fileValueOf: fileOop.
	handle := self cCode: 'GetStdHandle(STD_INPUT_HANDLE)' inSmalltalk: [-1].
	(handle ~= invalid)
		ifTrue: [interpreterProxy stObject: result at: 2 put: interpreterProxy trueObject]
		ifFalse: [interpreterProxy stObject: result at: 2 put: interpreterProxy falseObject].
	self cCode: 'file->file = handle'.
	self cCode: 'file->sessionID = thisSession'.
	self cCode: 'file->writable = 0'.
	self cCode: 'file->lastOp = 0'.
	interpreterProxy stObject: result at: 1 put: fileOop.
	interpreterProxy pop: 2; push: result
