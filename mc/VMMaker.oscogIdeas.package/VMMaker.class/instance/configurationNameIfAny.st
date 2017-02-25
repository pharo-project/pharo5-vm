generate sources
configurationNameIfAny
	^self configurationGeneratorNameOrNil
		ifNotNil: [:ctxt| (self class configurationNameFromSelector: ctxt selector), ' ']
		ifNil: [' ']