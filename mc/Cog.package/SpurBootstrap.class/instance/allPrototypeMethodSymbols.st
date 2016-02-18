method prototypes
allPrototypeMethodSymbols
	"self basicNew allPrototypeMethodSymbols"
	| symbols |
	"self assert: SpurBootstrap isolatedPrototypes isEmpty."
	symbols := Set new.
	self prototypeClassNameMetaSelectorMethodDo:
		[:className :isMeta :selector :method | | adder |
		symbols
			add: className;
			add: selector.	
		adder := [:lit|
				   (lit isSymbol and: [lit ~~ method selector]) ifTrue: [symbols add: lit].
				   lit isArray ifTrue: [lit do: adder]].
		method literals do: adder].
	^symbols