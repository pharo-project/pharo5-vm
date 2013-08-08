sample scripts
browse: anUrl
	"Open Web Browser to a page
		Applescript browse: 'http://squeak.org'
	"
	^self doIt: 'open location "', anUrl, '" '