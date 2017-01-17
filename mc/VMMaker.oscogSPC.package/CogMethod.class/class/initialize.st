class initialization
initialize
	"self initialize"
	(Smalltalk classNamed: #CogMethodSurrogate32) ifNotNil:
		[:cms32|
		self checkGenerateSurrogate: cms32 bytesPerWord: 4].
	(Smalltalk classNamed: #CogMethodSurrogate64) ifNotNil:
		[:cms64|
		self checkGenerateSurrogate: cms64 bytesPerWord: 8]