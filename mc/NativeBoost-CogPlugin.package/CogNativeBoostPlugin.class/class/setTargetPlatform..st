as yet unclassified
setTargetPlatform: aPlatformName
	" See a NativeBoostConstants for reference.
	
	NativeBoostPlugin setTargetPlatform: #Win32PlatformId
	"
	PlatformId := NativeBoostConstants classPool at: aPlatformName