building trace
buildTrace
" self build "
	"build for platform we're currently running on"
	| platform |
	
	platform := Smalltalk os platformName.
	
	platform = 'Win32' ifTrue:  [ ^ self buildTraceWin32 ].
	platform = 'Mac OS' ifTrue:  [ ^ self buildTraceMacOSX32 ].
	platform  = 'unix' ifTrue: [ ^ self buildTraceUnix32 ].