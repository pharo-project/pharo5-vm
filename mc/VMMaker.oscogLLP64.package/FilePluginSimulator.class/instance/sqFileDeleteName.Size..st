simulation
sqFileDeleteName: nameIndex Size: nameSize
	| path |
	path := interpreterProxy interpreter asString: nameIndex size: nameSize.
	(StandardFileStream isAFileNamed: path) ifFalse:
		[^interpreterProxy primitiveFail].
	[FileDirectory deleteFilePath: path]
		on: Error
		do: [:ex| interpreterProxy primitiveFail]