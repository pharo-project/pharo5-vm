utilities
instVarNamesForClass: aClass
	^vmClass
		ifNil: [aClass instVarNames]
		ifNotNil: [aClass instVarNames reject:
					[:ivn| vmClass isNonArgumentImplicitReceiverVariableName: ivn]]