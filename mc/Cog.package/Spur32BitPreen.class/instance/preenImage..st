public access
preenImage: imageName
	(Smalltalk classNamed: #FileReference) ifNotNil:
		[^self preenImageUsingFileReference: imageName].
	(Smalltalk classNamed: #FileDirectory) ifNotNil:
		[^self preenImageUsingFileDirectory: imageName].
	self error: 'at a loss as to what file system support to use'