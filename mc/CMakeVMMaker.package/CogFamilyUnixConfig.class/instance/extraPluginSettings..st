plugin extra rules
extraPluginSettings: maker

	maker isExternal ifTrue: [
		"copy lib to results dir "
		maker set: 'LIBRARY_OUTPUT_PATH' to: '${outputDir}' 
	].
