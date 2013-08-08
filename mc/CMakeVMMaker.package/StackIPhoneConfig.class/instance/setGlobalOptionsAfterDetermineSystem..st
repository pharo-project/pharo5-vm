utils
setGlobalOptionsAfterDetermineSystem: maker
	self setGlobalOptions: maker.	
	maker 
		set: 'CMAKE_OSX_SYSROOT' 
		to: ('/Applications/Xcode.app/Contents/Developer/Platforms/{1}.platform/Developer/SDKs/{1}{2}.sdk'
			format: { self targetDevice. self sdkVersion })