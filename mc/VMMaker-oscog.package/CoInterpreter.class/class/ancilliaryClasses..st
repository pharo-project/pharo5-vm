translation
ancilliaryClasses: options
	"Answer any extra classes to be included in the translation."
	^((super ancilliaryClasses: options) copyWithout: InterpreterStackPages),
	   {	CoInterpreterStackPages.
		CogBlockMethod },
	((Cogit ancilliaryClasses: options) select: [:class| class inheritsFrom: CogBlockMethod])