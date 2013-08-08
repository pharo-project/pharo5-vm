initialize-release
shutdownModule
"do any window related VM closing down work your platform requires."
	self export: true.
	^self cCode: 'ioCloseAllWindows()' inSmalltalk:[true]