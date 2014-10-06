as yet unclassified
extraPluginSettings: maker

	maker isExternal ifTrue: [
		"copy lib to results dir "
		maker set: 'LIBRARY_OUTPUT_PATH' to: '${outputDir}' .
		maker linkDirectories: '${CMAKE_FIND_ROOT_PATH}/usr/lib/arm-linux-gnueabihf/'.
	 	
	].	
	
	maker set: #linkFlags toString: '${linkFlags}'
