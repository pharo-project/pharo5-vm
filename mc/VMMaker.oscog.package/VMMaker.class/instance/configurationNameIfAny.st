generate sources
configurationNameIfAny
	^self configurationGeneratorNameOrNil
		ifNotNil: [:ctxt| (self class configuirationNameFromSelector: ctxt selector), ' ']
		ifNil: [' ']