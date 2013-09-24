method prototypes
allPrototypeMethodSymbols
	"self basicNew allPrototypeMethodSymbols"
	| symbols |
	symbols := Set new.
	self prototypeClassNameMetaSelectorMethodDo:
		[:className :isMeta :selector :method |
		symbols
			add: className;
			add: selector;
			addAll: (method literals select: [:l| l isSymbol and: [l ~~ method selector]])].
	^symbols