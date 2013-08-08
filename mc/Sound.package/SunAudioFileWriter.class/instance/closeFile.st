other
closeFile
	"Update the Sun audio file header to reflect the final size of the sound data. If my stream is a file stream, close it and, on a Macintosh, set the file type and creator to that used by SoundApp for Sun Audio files. (This does nothing on other platforms.)"

	self ensureOpen.
	self updateHeaderDataSize.
	(stream isKindOf: StandardFileStream) ifTrue: [
		stream close.
		FileSystem workingDirectory setMacFileNamed: stream name type: 'ULAW' creator: 'SCPL'].
