building trace
buildTraceOnJenkins: aPlatformName
	"entry point for jenkins build jobs.
	currently we use following names:
		win
		mac
		linux
	
	"
	
	aPlatformName = 'win' ifTrue: [ ^ self buildTraceWin32 ].
	aPlatformName = 'mac' ifTrue: [ ^ self buildTraceMacOSX32 ].
	aPlatformName = 'linux' ifTrue: [ ^ self buildTraceUnix32 ].
	
	self error: 'no suitable platform'