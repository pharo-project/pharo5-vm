settings
setCommonProperties: maker 
	maker set: 'CMAKE_CROSSCOMPILING' to: 'TRUE'.
	maker set: 'CMAKE_SYSTEM_NAME' to: 'Darwin'.
	maker set: 'CMAKE_SYSTEM_PROCESSOR' to: 'i386'.

	maker 
		set: 'SDKVER' 
		toString: self sdkVersion.
	maker 
		set: 'DEVROOT' 
		toString: ('/Applications/Xcode.app/Contents/Developer/Platforms/{1}.platform/Developer' 
			format: { self targetDevice }).
	maker 
		set: 'SDKROOT' 
		toString: ('$\{DEVROOT\}/SDKs/{1}$\{SDKVER\}.sdk' format: { self targetDevice }).

	maker set: 'CMAKE_OSX_SYSROOT' to: self sysroot.
		
	maker set: 'CMAKE_FIND_ROOT_PATH' to: '"${SDKROOT}" "${DEVROOT}"'.
	maker set: 'CMAKE_FIND_ROOT_PATH_MODE_PROGRAM' to: 'ONLY'.
	maker set: 'CMAKE_FIND_ROOT_PATH_MODE_LIBRARY' to: 'ONLY'.
	maker set: 'CMAKE_FIND_ROOT_PATH_MODE_INCLUDE' to: 'ONLY'.
	
	maker 
		set: 'CMAKE_EXE_LINKER_FLAGS' 
		toString: '-mios-simulator-version-min=${SDKVER} --sysroot ${SDKROOT} -L${SDKROOT}/usr/lib -L${SDKROOT}/usr/lib/system'.
	maker 
		set: 'CMAKE_C_FLAGS' 
		toString: '--sysroot ${SDKROOT} -L${SDKROOT}/usr/lib -L${SDKROOT}/usr/lib/system'.
	maker 
		set: 'CMAKE_CXX_FLAGS' 
		toString: '--sysroot ${SDKROOT} -L${SDKROOT}/usr/lib -L${SDKROOT}/usr/lib/system'.

	maker addFrameworks: self frameworks.