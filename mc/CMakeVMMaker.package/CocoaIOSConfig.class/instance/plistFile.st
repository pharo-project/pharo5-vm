bundle strings
plistFile
	| plist |
	
	plist := self plistTemplate.	
	self plistKeys
		do: [:key | 
			plist := plist 
				copyReplaceAll: '@' , key , '@' 
				with: (self perform: key) asString ].

	^ self fixLineEndsOf: plist