public
initializeCTranslationDictionary 
	"Initialize the dictionary mapping message names to actions for C code generation."

	super initializeCTranslationDictionary.
	translationDict
		at: #expandDereferenceInterpreterProxyFunctionTable
		put: #generateInterpreterProxyFunctionDeference:on:indent: