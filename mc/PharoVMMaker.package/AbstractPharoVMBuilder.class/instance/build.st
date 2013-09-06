building
build	
	"Build the VM source for the current platform"

	Smalltalk os isUnix
		ifTrue: [ ^ self buildUnix32 ].
	Smalltalk os isMacOSX
		ifTrue: [ ^ self buildMacOSX32 ].
	Smalltalk os isWin32
		ifTrue: [ ^ self buildWin32 ].
	Error signal: 'Unknown host platform to build the VM for'.