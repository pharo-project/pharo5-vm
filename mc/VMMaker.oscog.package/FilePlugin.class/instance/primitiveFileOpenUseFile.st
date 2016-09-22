file primitives
primitiveFileOpenUseFile
	| writeFlag cfile filePointer |
	<var: 'cfile' type: 'FILE* '>
	<export: true>
	writeFlag := interpreterProxy
				booleanValueOf: (interpreterProxy stackValue: 0).
	cfile := self cfileValueOf: (interpreterProxy stackValue: 1).
	interpreterProxy failed
		ifFalse: [filePointer := self fileOpenFile: cfile write: writeFlag].
	interpreterProxy failed
		ifFalse: [interpreterProxy pop: 3 "rcvr, name, writeFlag"
			thenPush: filePointer]
