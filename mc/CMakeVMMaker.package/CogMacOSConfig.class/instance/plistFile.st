bundle strings
plistFile

	| plist |
	
	plist := self plistTemplate.
	
	#(
	CFBundleExecutable
	CFBundleGetInfoString
	CFBundleName
	CFBundleShortVersionString
	CFBundleVersion
	CFBundleIconFile
	CFBundleIdentifier ) do: [:key |
		plist := plist copyReplaceAll: '@' , key , '@' with: (self perform: key)
	].

	^ self fixLineEndsOf: plist