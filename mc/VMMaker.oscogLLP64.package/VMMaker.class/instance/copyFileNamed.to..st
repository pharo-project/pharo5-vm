private - copying files
copyFileNamed: srcName to: dstName 
	| dstEntry srcEntry |
	dstEntry := FileDirectory directoryEntryFor: dstName.
	dstEntry ifNotNil:[
		srcEntry := FileDirectory directoryEntryFor: srcName.
		srcEntry ifNil:[^self couldNotOpenFile: srcName].
		dstEntry modificationTime >= srcEntry modificationTime ifTrue:[^self].
	].
	logger show:'==> ', dstName; cr.
	^self primitiveCopyFileNamed: srcName to: dstName 