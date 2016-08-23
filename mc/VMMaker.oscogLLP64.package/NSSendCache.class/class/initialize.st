class initialization
initialize
	"self initialize"
	(Smalltalk classNamed: #NSSendCacheSurrogate32) ifNotNil:
		[:scs32|
		self checkGenerateSurrogate: scs32 bytesPerWord: 4].
	(Smalltalk classNamed: #NSSendCacheSurrogate64) ifNotNil:
		[:scs64|
		self checkGenerateSurrogate: scs64 bytesPerWord: 8]