as yet unclassified
makeDirEntryName: entryName size: entryNameSize createDate: createDate modDate: modifiedDate isDir: dirFlag fileSize: fileSize posixPermissions: posixPermissions isSymlink: symlinkFlag

	^(pluginList
		detect: [:assoc| assoc key = 'FilePlugin']
		ifNone: [self error: 'this message should not be sent unless the FilePlugin has been loaded']) value
			makeDirEntryName: entryName size: entryNameSize
				createDate: createDate modDate: modifiedDate
					isDir: dirFlag fileSize: fileSize
						posixPermissions: fileSize isSymlink: symlinkFlag