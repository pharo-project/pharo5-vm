objects from disk
saveConfigurationTo: aFile
	"Write info about the current configuration to a file.
	 Use a hack CrForSpaceWriteStream so that things
	 appear on separate lines to be friendly to configuration
	 management systems diffing facilities."
	| stream |
	stream := CrForSpaceWriteStream on: String new.
	self configurationInfo storeOn: stream.
	(MultiByteFileStream newFileNamed: aFile)
		lineEndConvention: #lf;
		nextPutAll: stream contents;
		close