file primitives
makeDirEntryName: entryName size: entryNameSize createDate: createDate modDate: modifiedDate isDir: dirFlag fileSize: fileSize posixPermissions: posixPermissions isSymlink: symlinkFlag
	"This is used just by the PharoVM, at the moment"
	
	^interpreterProxy
		makeDirEntryName: entryName 
		size: entryNameSize
		createDate: createDate 
		modDate: modifiedDate
		isDir: dirFlag 
		fileSize: fileSize
		posixPermissions: posixPermissions
		isSymlink: symlinkFlag