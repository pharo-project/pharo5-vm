private - copying files
copyFileNamed: srcName to: dstName 
	| dstEntry srcEntry |
	dstEntry := dstName asFileReference entry.
	dstEntry ifNotNil:[
		srcEntry := srcName asFileReference entry.
		srcEntry ifNil:[^self couldNotOpenFile: srcName].
		dstEntry modificationTime >= srcEntry modificationTime ifTrue:[^self].
	].
	logger show:'==> ', dstName; cr.
	^self primitiveCopyFileNamed: srcName to: dstName 