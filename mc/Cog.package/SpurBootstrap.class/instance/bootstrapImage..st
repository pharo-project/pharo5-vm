public access
bootstrapImage: imageName
	(Smalltalk classNamed: #FileReference) ifNotNil:
		[^self bootstrapImageUsingFileReference: imageName].
	(Smalltalk classNamed: #FileDirectory) ifNotNil:
		[^self bootstrapImageUsingFileDirectory: imageName].
	self error: 'at a loss as to what file system support to use'