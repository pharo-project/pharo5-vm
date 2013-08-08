deprecated
primitiveIsAtEndOfFile
	"Take a struct SQFile from the stack, and call feof(3) to determine if the file has
	reached end of file."

	"Deprecated. The return values are reversed. Use primitiveTestEndOfFileFlag."

	| sqFileOop file result |
	<export: true>
	<var: 'file' type: 'FILEHANDLETYPE'>
	sqFileOop := interpreterProxy stackValue: 0.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	file := self fileHandleFrom: sqFileOop.
	(file = 0) ifTrue: [^ self primitiveFail].
	(self feof: file)
		ifFalse: [result := interpreterProxy falseObject]
		ifTrue: [result := interpreterProxy trueObject].
	interpreterProxy pop: 2; push: result

