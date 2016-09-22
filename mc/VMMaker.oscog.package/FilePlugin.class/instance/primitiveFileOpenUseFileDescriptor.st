file primitives
primitiveFileOpenUseFileDescriptor
	| writeFlag fdPointer fd filePointer |
	<var: 'fd' type: 'int'>
	<export: true>
	writeFlag := interpreterProxy
				booleanValueOf: (interpreterProxy stackValue: 0).
	fdPointer := interpreterProxy stackValue: 1.
	(interpreterProxy isIntegerObject: fdPointer)
		ifFalse: [^ interpreterProxy primitiveFail].
	fd := interpreterProxy integerValueOf: fdPointer.
	filePointer := self fileOpenFd: fd write: writeFlag.
	interpreterProxy failed
		ifFalse: [interpreterProxy pop: 3 "rcvr, name, writeFlag"
			thenPush: filePointer]
