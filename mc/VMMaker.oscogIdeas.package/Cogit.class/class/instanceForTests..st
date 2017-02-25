in-image compilation
instanceForTests: optionsDictionaryOrArray
	"Initialize all the relevant classes from the options and answer a new instance of me."
	| initOptions |
	initOptions := self asOptionsDictionary: optionsDictionaryOrArray.
	CoInterpreter initializeWithOptions: initOptions.
	CoInterpreter objectMemoryClass initializeWithOptions: initOptions.
	self initializeWithOptions: initOptions.
	^self new