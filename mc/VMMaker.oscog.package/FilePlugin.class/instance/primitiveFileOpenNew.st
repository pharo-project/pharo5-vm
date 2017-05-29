file primitives
primitiveFileOpenNew
	| namePointer filePointer nameIndex nameSize |
	<var: 'nameIndex' type: 'char *'>
	<export: true>
	namePointer := interpreterProxy stackValue: 0.
	(interpreterProxy isBytes: namePointer)
		ifFalse: [^ interpreterProxy primitiveFail].
	nameIndex := interpreterProxy firstIndexableField: namePointer.
	nameSize := interpreterProxy byteSizeOf: namePointer.
	filePointer := self fileOpenNewName: nameIndex size: nameSize secure: true.
	interpreterProxy failed
		ifFalse: [
			interpreterProxy
				pop: 2 "rcvr, name"
				thenPush: filePointer]
