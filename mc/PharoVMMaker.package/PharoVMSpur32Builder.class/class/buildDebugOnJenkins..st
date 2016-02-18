building debug
buildDebugOnJenkins: aPlatformName
	"entry point for jenkins build jobs.
	currently we use following names:
		win
		mac
		linux
	
	"
	
	aPlatformName = 'win' ifTrue: [ ^ self buildDebugWin32 ].
	aPlatformName = 'mac' ifTrue: [ ^ self buildDebugMacOSX32 ].
	aPlatformName = 'linux' ifTrue: [ ^ self buildDebugUnix32 ].
	
	self error: 'no suitable platform'