settings
setExtraTargetProperties: maker
	"super setExtraTargetProperties: maker."

	| precompiledHeaders plist |
	
	precompiledHeaders := (self executableName, '_Prefix.pch').
	(FileStream forceNewFileNamed: (maker buildDir / precompiledHeaders) fullName) 
		nextPutAll: self precompiledHeaders;
		close.
	
	maker addXCodeProperty: 'GCC_PREFIX_HEADER' value: '${buildDir}/', precompiledHeaders.
	
	self setCommonProperties: maker.

	" generated and add Info.plist file "
	plist := self plistFile.
	(FileStream forceNewFileNamed: (maker buildDir / 'Info.plist') fullName) 
		nextPutAll: plist; 
		close.

	maker addProperty: 'MACOSX_BUNDLE_INFO_PLIST' value: '${buildDir}/Info.plist'.  
	maker 
		cmd: 'set_target_properties' 
		params: self executableName, ' PROPERTIES COMPILE_FLAGS "-include \"', (self buildDir / self prefixHeaderFileName) fullName, '\""'. 

	maker 
		set: 'CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY' 
		toString: self codeSignIdentity.
	maker 
		set: 'CMAKE_XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY' 
		toString: self targetedDeviceFamilyAsString.
	maker 
		set: 'CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET' 
		to: self deploymentTargetVersion.
	maker 
		set: 'CMAKE_XCODE_ATTRIBUTE_CONFIGURATION_BUILD_DIR' 
		toString: '$(BUILD_DIR)/$(CONFIGURATION)'.
	maker 
		set: 'CMAKE_XCODE_ATTRIBUTE_CONFIGURATION_TEMP_DIR' 
		toString: '$(BUILD_DIR)/$(CONFIGURATION)'.

	maker set: 'EXECUTABLE_OUTPUT_PATH' toString: self outputDir fullName.
	
	maker puts: 'set_source_files_properties(${srcVMDir}/gcc3x-cointerp.c PROPERTIES COMPILE_FLAGS -O0)'.


