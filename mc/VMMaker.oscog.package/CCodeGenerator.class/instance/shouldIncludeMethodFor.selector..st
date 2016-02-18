utilities
shouldIncludeMethodFor: aClass selector: selector
	"Answer whether a method shoud be translated.  Process optional methods by
	 interpreting the argument to the option: pragma as either a Cogit class name
	 or a class variable name or a variable name in VMBasicConstants.  Exclude
	 methods with the doNotGenerate pragma."
	| optionPragmas notOptionPragmas |
	(aClass >> selector pragmaAt: #doNotGenerate) ifNotNil:
		[^false].

	"where is pragmasAt: ??"
	optionPragmas := (aClass >> selector) pragmas select: [:p| p keyword == #option:].
	notOptionPragmas := (aClass >> selector) pragmas select: [:p| p keyword == #notOption:].
	(optionPragmas notEmpty or: [notOptionPragmas notEmpty]) ifTrue:
		[^(optionPragmas allSatisfy: [:pragma| self optionIsTrue: pragma in: aClass])
		   and: [notOptionPragmas noneSatisfy: [:pragma| self optionIsTrue: pragma in: aClass]]].

	^true