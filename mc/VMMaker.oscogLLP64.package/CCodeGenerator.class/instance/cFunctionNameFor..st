C code generator
cFunctionNameFor: aSelector
	"Create a C function name from the given selector by finding
	 a specific translation, or if none, simply omitting colons."
	^selectorTranslations at: aSelector ifAbsent: [aSelector copyWithout: $:]