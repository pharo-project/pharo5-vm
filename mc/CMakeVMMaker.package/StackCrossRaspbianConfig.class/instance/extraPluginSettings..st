as yet unclassified
extraPluginSettings: maker
	
	maker linkDirectories: '${CMAKE_FIND_ROOT_PATH}/usr/lib/arm-linux-gnueabihf/'.

	maker isExternal ifTrue: [
		"copy lib to results dir "
		maker set: 'LIBRARY_OUTPUT_PATH' to: '${outputDir}' .
	 	
	].	
	
	maker set: #linkFlags toString: '${linkFlags}'
