file primitives
fileOpenNewName: nameIndex size: nameSize secure: secureFlag
	"Open the new named file, possibly checking security. Answer the file oop."
	| path f index |
	openFiles size >= maxOpenFiles ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrLimitExceeded].
	path := interpreterProxy interpreter asString: nameIndex size: nameSize.
	"the #defaultAction for FileExistsException creates a dialog,
	so it is caught and resignaled as a generic Error"
	[f := FileStream newFileNamed: nameIndex]
		on: FileExistsException
		do: [:error | ^ interpreterProxy primitiveFailFor: PrimErrInappropriate].
	f ifNil: [^interpreterProxy primitiveFail].
	f binary.
	index := openFiles size + 1.
	openFiles at: index put: f.
	^interpreterProxy integerObjectOf: index