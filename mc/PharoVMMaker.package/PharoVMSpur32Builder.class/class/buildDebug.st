building debug
buildDebug
" self build "
	"build for platform we're currently running on"
	| platform |
	
	platform := Smalltalk os platformName.
	
	platform = 'Win32' ifTrue:  [ ^ self buildDebugWin32 ].
	platform = 'Mac OS' ifTrue:  [ ^ self buildDebugMacOSX32 ].
	platform  = 'unix' ifTrue: [ ^ self buildDebugUnix32 ].