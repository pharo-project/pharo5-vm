simulation
makeDirEntryName: entryName size: entryNameSize
	createDate: createDate modDate: modifiedDate
	isDir: dirFlag fileSize: fileSize

	^interpreterProxy
		makeDirEntryName: entryName size: entryNameSize
		createDate: createDate modDate: modifiedDate
		isDir: dirFlag fileSize: fileSize
