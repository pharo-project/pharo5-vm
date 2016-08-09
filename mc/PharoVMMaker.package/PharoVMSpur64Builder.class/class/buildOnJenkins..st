building
buildOnJenkins: aPlatformName
	"entry point for jenkins build jobs.
	currently we use following names:
		win
		mac
		linux
	
	"
	
	aPlatformName = 'win' ifTrue: [ ^ self buildWin64 ].
	aPlatformName = 'mac' ifTrue: [ ^ self buildMacOSX64 ].
	aPlatformName = 'linux' ifTrue: [ ^ self buildUnix64 ].
	
	self error: 'no suitable platform'