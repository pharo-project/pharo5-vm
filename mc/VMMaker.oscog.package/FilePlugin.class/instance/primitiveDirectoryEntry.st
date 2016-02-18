directory primitives
primitiveDirectoryEntry

	"Two arguments - directory path, and simple file name;
 	 returns an array (see primitiveDirectoryLookup) describing the file or directory,
 	 or nil if it does not exist.  
	 Primitive fails if the outer path does not identify a readable directory.
	 (This is a lookup-by-name variant of primitiveDirectoryLookup.)"

	| requestedName pathName pathNameIndex pathNameSize status entryName entryNameSize createDate modifiedDate dirFlag posixPermissions symlinkFlag fileSize okToList reqNameIndex reqNameSize |
	
	<var: 'entryName' declareC: 'char entryName[256]'>
	<var: 'pathNameIndex' type: 'char *'>
	<var: 'reqNameIndex' type: 'char *'>
	<var: 'fileSize' type: 'squeakFileOffsetType'>
	<export: true>

	requestedName := interpreterProxy stackValue: 0.
	pathName := interpreterProxy stackValue: 1.
	(interpreterProxy isBytes: pathName)
		ifFalse: [^interpreterProxy primitiveFail].

	"Outbound string parameters"
	pathNameIndex := interpreterProxy firstIndexableField: pathName.
	pathNameSize := interpreterProxy byteSizeOf: pathName.

	reqNameIndex := interpreterProxy firstIndexableField: requestedName.
	reqNameSize := interpreterProxy byteSizeOf: requestedName.

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
					status := self cCode: 'dir_EntryLookup(pathNameIndex, pathNameSize, reqNameIndex, reqNameSize,										  
														entryName, &entryNameSize, &createDate,
														&modifiedDate, &dirFlag, &fileSize, 
														&posixPermissions, &symlinkFlag)' ]
				ifFalse: [ 
					status := self cCode: 'dir_EntryLookup(pathNameIndex, pathNameSize, reqNameIndex, reqNameSize,
													  entryName, &entryNameSize, &createDate,
													  &modifiedDate, &dirFlag, &fileSize)'] ]
		ifFalse: [status := DirNoMoreEntries].

	interpreterProxy failed
		ifTrue: [^nil].
	status = DirNoMoreEntries
		ifTrue: ["no entry; return nil"
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
				pop: 3	"pop pathName, fName, rcvr" 
				thenPush: (self
					makeDirEntryName: entryName
					size: entryNameSize
					createDate: createDate
					modDate: modifiedDate
					isDir: dirFlag
					fileSize: fileSize) ]