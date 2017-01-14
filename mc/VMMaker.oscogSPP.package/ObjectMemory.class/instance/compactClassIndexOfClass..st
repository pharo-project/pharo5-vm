object format
compactClassIndexOfClass: classObj
	<api>
	^self compactClassIndexOfHeader: (self formatOfClass: classObj)