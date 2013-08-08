settings
setExtraTargetProperties: maker

	super setExtraTargetProperties: maker.

	maker addFrameworks: self frameworks.	

	" generated and add Info.plist file "
	self write: self plistFile toFile: 'Info.plist'.
	maker 
		addProperty: 'MACOSX_BUNDLE_INFO_PLIST' 
		value: '${buildDir}/Info.plist'.

	maker cmd: 'set_source_files_properties' params: '${resources} PROPERTIES MACOSX_PACKAGE_LOCATION Resources'.
	
	maker set: 'EXECUTABLE_OUTPUT_PATH' to: '${outputDir}'.