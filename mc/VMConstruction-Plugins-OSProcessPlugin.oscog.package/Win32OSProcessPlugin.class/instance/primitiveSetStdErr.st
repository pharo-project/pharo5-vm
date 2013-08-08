primitives - files
primitiveSetStdErr
	"Set the file handle for standard error of my OS process to the handle passed in a SQFile struct."

	| sqFileOop handle |
	<export: true>
	<var: 'sqFile' type: 'SQFile *'>
	<var: 'handle' type: 'FILEHANDLETYPE'>
	sqFileOop := interpreterProxy stackValue: 0.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	handle := self fileHandleFrom: sqFileOop.
	(self cCode: 'SetStdHandle(STD_ERROR_HANDLE, handle)' inSmalltalk: [false])
		ifTrue: [interpreterProxy pop: 2 thenPush: interpreterProxy trueObject]
		ifFalse: [interpreterProxy pop: 2 thenPush: interpreterProxy falseObject]
