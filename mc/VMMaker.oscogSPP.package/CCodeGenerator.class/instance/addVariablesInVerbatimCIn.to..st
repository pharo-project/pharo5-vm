utilities
addVariablesInVerbatimCIn: aCCodeSendNode to: aCollection
	"If aCCodeSendNode has a string argument, parse it and extract anything
	 that looks like a variable, and add the resulting vars to aCollection."
	| separators tokens |
	(aCCodeSendNode isSend
	 and: [(aCCodeSendNode selector beginsWith: #cCode:)
	 and: [aCCodeSendNode args first isConstant
	 and: [aCCodeSendNode args first value isString]]]) ifFalse:
		[^self].
	separators := (Character space to: 255 asCharacter) reject:
					[:char|
					char isLetter or: [char isDigit or: [char = $_]]].
	tokens := aCCodeSendNode args first value findTokens: separators.
	aCollection addAll: (tokens select: [:token| token first isLetter]) asSet