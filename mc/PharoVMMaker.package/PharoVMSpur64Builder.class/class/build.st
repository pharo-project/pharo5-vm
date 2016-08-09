building
build
" self build "
	"build for platform we're currently running on"
	| platform |
	
	platform := Smalltalk os platformName.
	
	platform = 'Win32' ifTrue:  [ ^ self buildWin64 ].
	platform = 'Mac OS' ifTrue:  [ ^ self buildMacOSX64 ].
	platform  = 'unix' ifTrue: [ ^ self buildUnix64 ].