translation
ancilliaryClasses
	"Answer any extra classes to be included in the translation."
	^super ancilliaryClasses
		copyReplaceAll: { InterpreterStackPages }
		with: { CoInterpreterStackPages }