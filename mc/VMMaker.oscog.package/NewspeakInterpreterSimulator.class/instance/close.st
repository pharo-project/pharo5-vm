initialization
close  "close any files that ST may have opened"
	(self loadNewPlugin: 'FilePlugin') ifNotNil:
		[:filePlugin| filePlugin close]