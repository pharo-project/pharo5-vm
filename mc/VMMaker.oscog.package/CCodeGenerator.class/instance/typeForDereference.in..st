type inference
typeForDereference: sendNode in: aTMethod
	(self typeFor: sendNode receiver in: aTMethod) ifNotNil:
		[:type|
		 type last = $* ifTrue:
			[^type allButLast withBlanksTrimmed]].
	"It would be nice to warn here, but there are contexts when the type is unknown, for example determining
	 the return types of apiMethods.  inferTypesForImplicitlyTypedVariablesAndMethods could provide a signal
	 handler to suppress the warnings in that case but that's too fancy.  Instead we live with the default."
	"logger
		nextPutAll: 'warning, cannot determine type of at: for ', sendNode receiver asString, ' in ', aTMethod selector;
		cr."
	^#sqInt