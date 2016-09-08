file primitives
fileOpenName: nameIndex size: nameSize write: writeFlag secure: secureFlag
	"Open the named file, possibly checking security. Answer the file oop."
	| path f index |
	openFiles size >= maxOpenFiles ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrLimitExceeded].
	path := interpreterProxy interpreter asString: nameIndex size: nameSize.
	f := writeFlag
			ifTrue: [FileStream fileNamed: path]
			ifFalse:
				[(StandardFileStream isAFileNamed: path) ifTrue:
					[FileStream readOnlyFileNamed: path]].
	f ifNil: [^interpreterProxy primitiveFail].
	f binary.
	index := openFiles size + 1.
	openFiles at: index put: f.
	^interpreterProxy integerObjectOf: index