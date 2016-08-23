simulation
sqFileRenameOld: oldNameIndex Size: oldNameSize New: newNameIndex Size: newNameSize
	| oldPath newPath |
	oldPath := FileDirectory default fullNameFor: (interpreterProxy interpreter asString: oldNameIndex size: oldNameSize).
	newPath := FileDirectory default fullNameFor: (interpreterProxy interpreter asString: newNameIndex size: newNameSize).
	((StandardFileStream isAFileNamed: oldPath)
	 and: [(StandardFileStream isAFileNamed: newPath) not]) ifFalse:
		[^interpreterProxy primitiveFail].
	[FileDirectory default primRename: oldPath to: newPath]
		on: Error
		do: [:ex| interpreterProxy primitiveFail]