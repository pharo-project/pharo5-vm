directory primitives
primitiveDirectoryLookup

	| index pathName pathNameIndex pathNameSize status entryName entryNameSize createDate modifiedDate dirFlag symlinkFlag posixPermissions fileSize okToList |
	
	<var: 'entryName' declareC: 'char entryName[256]'>
	<var: 'pathNameIndex' type: 'char *'>
	<var: 'fileSize' type: 'squeakFileOffsetType'>
	<export: true>

	index := interpreterProxy stackIntegerValue: 0.
	pathName := interpreterProxy stackValue: 1.
	(interpreterProxy isBytes: pathName)
		ifFalse: [^interpreterProxy primitiveFail].
	pathNameIndex := interpreterProxy firstIndexableField: pathName.
	pathNameSize := interpreterProxy byteSizeOf: pathName.
	"If the security plugin can be loaded, use it to check for permission. 
	If not, assume it's ok"
	sCLPfn ~= 0
		ifTrue: [okToList := self cCode: '((sqInt (*)(char *, sqInt))sCLPfn)(pathNameIndex, pathNameSize)']
		ifFalse: [okToList := true].
	okToList
		ifTrue: [
			self 
				cppIf: PharoVM 
				ifTrue: [ 
					status := self cCode: 'dir_Lookup(pathNameIndex, pathNameSize, index,
												entryName, &entryNameSize, &createDate,
												&modifiedDate, &dirFlag, &fileSize, 
												&posixPermissions, &symlinkFlag)' ]
				ifFalse: [ 
					status := self cCode: 'dir_Lookup(pathNameIndex, pathNameSize, index,
												entryName, &entryNameSize, &createDate,
												&modifiedDate, &dirFlag, &fileSize)' ] ]
		ifFalse: [status := DirNoMoreEntries].
	interpreterProxy failed
		ifTrue: [^nil].
	status = DirNoMoreEntries
		ifTrue: ["no more entries; return nil"
			interpreterProxy pop: 3 "pop pathName, index, rcvr"
				thenPush: interpreterProxy nilObject.
			^nil].
	status = DirBadPath
		ifTrue: [^interpreterProxy primitiveFail]."bad path"

	self 
		cppIf: PharoVM 
		ifTrue: [ 
			interpreterProxy 
				pop: 3	"pop pathName, index, rcvr" 
				thenPush: (self
					makeDirEntryName: entryName
					size: entryNameSize
					createDate: createDate
					modDate: modifiedDate
					isDir: dirFlag
					fileSize: fileSize
					posixPermissions: posixPermissions
					isSymlink: symlinkFlag) ]
		ifFalse: [ 
			interpreterProxy 
				pop: 3	"pop pathName, index, rcvr" 
				thenPush: (self
						makeDirEntryName: entryName
						size: entryNameSize
						createDate: createDate
						modDate: modifiedDate
						isDir: dirFlag
						fileSize: fileSize) ]