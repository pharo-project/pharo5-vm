source files
standardIncludes 
	^super standardIncludes, {
		'/Applications/Xcode.app/Contents/Developer/Platforms/{1}.platform/Developer/SDKs/{1}{2}.sdk/usr/include/'
			format: { 
				self targetDevice. 
				self sdkVersion} }
		 