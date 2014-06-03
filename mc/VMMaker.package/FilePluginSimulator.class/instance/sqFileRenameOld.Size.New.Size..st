simulation
sqFileRenameOld: oldNameIndex Size: oldNameSize New: newNameIndex Size: newNameSize
	| oldPath newPath |
	oldPath := (interpreterProxy interpreter asString: oldNameIndex size: oldNameSize) asFileReference fullName.
	newPath := (interpreterProxy interpreter asString: newNameIndex size: newNameSize) asFileReference fullName.
	((StandardFileStream isAFileNamed: oldPath)
	 and: [(StandardFileStream isAFileNamed: newPath) not]) ifFalse:
		[^interpreterProxy primitiveFail].
	[FileSystem workingDirectory primRename: oldPath to: newPath]
		on: Error
		do: [:ex| interpreterProxy primitiveFail]