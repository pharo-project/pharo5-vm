file primitives
makeDirEntryName: entryName size: entryNameSize
	createDate: createDate modDate: modifiedDate
		isDir: dirFlag fileSize: fileSize

	^(pluginList
		detect: [:assoc| assoc key = 'FilePlugin']
		ifNone: [self error: 'this message should not be sent unless the FilePlugin has been loaded']) value
			makeDirEntryName: entryName size: entryNameSize
				createDate: createDate modDate: modifiedDate
					isDir: dirFlag fileSize: fileSize