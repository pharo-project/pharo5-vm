plugins
extraPluginSettings: maker


	maker isExternal ifTrue: [
		"copy result to results dir "
		maker set: 'LIBRARY_OUTPUT_PATH' toString: '${outputDir}'.
		
		maker cmd: 'set_target_properties' params:  maker moduleName , ' PROPERTIES PREFIX "" '
	]