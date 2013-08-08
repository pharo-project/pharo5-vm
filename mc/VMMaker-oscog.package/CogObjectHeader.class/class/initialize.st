class initialization
initialize
	(Smalltalk classNamed: #CogObjectHeaderSurrogate) ifNotNil:
		[:cohs|
		self checkGenerateSurrogate: cohs bytesPerWord: 4].

	"CogObjectHeader initialize"