settings
setGlobalOptionsAfterDetermineSystem:  maker
	maker set: 'CMAKE_OSX_DEPLOYMENT_TARGET' to: '10.5'.
	maker 
		set: 'CMAKE_OSX_SYSROOT' 
		to: '/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX', self sdkVersion, '.sdk'