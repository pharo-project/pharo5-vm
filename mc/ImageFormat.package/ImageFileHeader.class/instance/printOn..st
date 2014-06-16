printing
printOn: aStream

	super printOn: aStream.
	imageFormat ifNotNil: [
		aStream nextPutAll: ' for '.
		imageFormat printDescriptionOn: aStream]