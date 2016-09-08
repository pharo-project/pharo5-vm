class initialization
initialize
	"CogBlockMethod initialize"
	"CogBlockMethod initialize. CogMethod initialize"
	(Smalltalk classNamed: #CogBlockMethodSurrogate32) ifNotNil:
		[:cbms32|
		self checkGenerateSurrogate: cbms32 bytesPerWord: 4].
	(Smalltalk classNamed: #CogBlockMethodSurrogate64) ifNotNil:
		[:cbms64|
		self checkGenerateSurrogate: cbms64 bytesPerWord: 8].

	"see instVarNamesAndTypesForTranslationDo:"
	CMMaxUsageCount		:= (2 raisedTo: 3) - 1.
	MaxStackCheckOffset	:= (2 raisedTo: 12) - 1.
	MaxMethodSize		:= (2 raisedTo: 16) - 1

	"{ CogBlockMethodSurrogate32 selectors reject: [:s| CogBlockMethod includesSelector: s].
	    CogBlockMethodSurrogate64 selectors reject: [:s| CogBlockMethod includesSelector: s].
	    CogMethodSurrogate32 selectors reject: [:s| CogMethod includesSelector: s].
	    CogMethodSurrogate64 selectors reject: [:s| CogMethod includesSelector: s]. }"