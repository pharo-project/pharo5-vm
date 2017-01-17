file primitives
primitiveFileOpen
	| writeFlag namePointer filePointer nameIndex nameSize |
	<var: 'nameIndex' type: 'char *'>
	<export: true>
	writeFlag := interpreterProxy
				booleanValueOf: (interpreterProxy stackValue: 0).
	namePointer := interpreterProxy stackValue: 1.
	(interpreterProxy isBytes: namePointer)
		ifFalse: [^ interpreterProxy primitiveFail].
	nameIndex := interpreterProxy firstIndexableField: namePointer.
	nameSize := interpreterProxy byteSizeOf: namePointer.
	filePointer := self fileOpenName: nameIndex size: nameSize write: writeFlag secure: true.
	interpreterProxy failed
		ifFalse: [interpreterProxy pop: 3 "rcvr, name, writeFlag"
			thenPush: filePointer]
