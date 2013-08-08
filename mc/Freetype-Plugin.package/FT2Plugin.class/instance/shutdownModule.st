initialize
shutdownModule
	self export: true.
	errorCode := self cCode: 'FT_Done_FreeType(library)' inSmalltalk:[0].
	errorCode == 0 ifTrue: [library := nil].
	^errorCode == 0