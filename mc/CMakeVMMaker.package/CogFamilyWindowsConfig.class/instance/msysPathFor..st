accessing
msysPathFor: aPath
	| path |
	
	path := aPath asFileReference fullName.
	
	path := path copyReplaceAll: '\' with: '/'.
	
	^ path " copyReplaceAll: '\' with: '\\'"