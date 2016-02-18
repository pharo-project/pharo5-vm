translation
ancilliaryClasses: options
	"Answer any extra classes to be included in the translation."
	^{	self objectMemoryClass.
		VMCallbackContext.
		CogStackPages.
		InterpreterStackPages.
		CogStackPage }