as yet unclassified
makeDirEntryName: entryName 
	size: entryNameSize
	createDate: createDate 
	modDate: modifiedDate
	isDir: dirFlag 
	fileSize: fileSize 
	posixPermissions: posixPermissions
	isSymlink: symlinkFlag
	
	^interpreterProxy
		makeDirEntryName: entryName 
		size: entryNameSize
		createDate: createDate 
		modDate: modifiedDate
		isDir: dirFlag 
		fileSize: fileSize
		posixPermissions: posixPermissions
		isSymlink: symlinkFlag
