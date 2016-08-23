translation
initialize
	"self initialize"
	(Smalltalk classNamed: #CogStackPageSurrogate32) ifNotNil:
		[:csps32|
		self checkGenerateSurrogate: csps32 bytesPerWord: 4].
	(Smalltalk classNamed: #CogStackPageSurrogate64) ifNotNil:
		[:csps64|
		self checkGenerateSurrogate: csps64 bytesPerWord: 8]