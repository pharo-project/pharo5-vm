initialize
initializeCTranslationDictionary 
	"Initialize the dictionary mapping message names to actions for C code generation."
	super initializeCTranslationDictionary.
	#(
	#ifDefined:						#generatePreprocessorCondition:on:indent:
	#ifNotDefined:					#generatePreprocessorCondition:on:indent:
	#else							#generatePreprocessorCondition:on:indent:
	#endIf							#generatePreprocessorCondition:on:indent:
	#ifDefined:then:					#generatePreprocessorCondition:on:indent:
	#ifDefined:then:else:			#generatePreprocessorCondition:on:indent:
	#ifNotDefined:then:				#generatePreprocessorCondition:on:indent:
	#ifNotDefined:then:else:			#generatePreprocessorCondition:on:indent:
	) pairsDo: [:selector :translated |
		translationDict at: selector put: translated].
