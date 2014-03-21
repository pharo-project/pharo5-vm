settings
setExtraTargetProperties: maker
	| plist |

	maker addFrameworks: self frameworks.

	" generated and add Info.plist file "
	plist := self plistFile.

	(FileStream forceNewFileNamed: (maker buildDir / 'Info.plist') fullName) 
		nextPutAll: plist; 
		close.

	maker 
		addProperty: 'MACOSX_BUNDLE_INFO_PLIST' 
		value: '${buildDir}/Info.plist'.  

	(FileStream forceNewFileNamed: (maker buildDir / self prefixHeaderFileName) fullName )
		nextPutAll: self precompiledHeaders;
		close.
	maker addXCodeProperty: 'GCC_PREFIX_HEADER' value: '${buildDir}/', self prefixHeaderFileName.

	maker 
		addXCodeProperty: 'PER_ARCH_CFLAGS_i386' value: '-DLSB_FIRST -mfpmath=sse -finline-functions  -fno-gcse -mtune=prescott -march=pentium-m -falign-functions=16'.
		
	"maker 
		addXCodeProperty: 'GCC_VERSION' value: '4.3'."

	maker 
		cmd: 'set_target_properties' 
		params: self executableName, ' PROPERTIES COMPILE_FLAGS "-include \"', (self buildDir / self prefixHeaderFileName) fullName, '\""'. 
		
"	maker set: 'CMAKE_C_COMPILER' to: '/usr/bin/gcc-4.2'.
	maker set: 'CMAKE_CXX_COMPILER' to: '/usr/bin/g++-4.2'.		
"
	maker set: 'EXECUTABLE_OUTPUT_PATH' toString: self outputDir fullName.
	maker set: 'RUNTIME_OUTPUT_DIRECTORY' toString: self outputDir fullName.