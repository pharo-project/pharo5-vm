primitives - files
primitiveTestEndOfFileFlag
	"Take a struct SQFile from the stack, and call feof(3) to determine if the file has
	reached end of file. The flag is set only by a previous read operation, so end of
	file is not detected until an actual EOF condition has been detected by a read attempt."

	| sqFileOop file result |
	<export: true>
	<var: 'file' type: 'FILEHANDLETYPE'>
	sqFileOop := interpreterProxy stackValue: 0.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	file := self fileHandleFrom: sqFileOop.
	(file = 0) ifTrue: [^ interpreterProxy primitiveFail].
	(self feof: file)
		ifTrue: [result := interpreterProxy trueObject]
		ifFalse: [result := interpreterProxy falseObject].
	interpreterProxy pop: 2; push: result

