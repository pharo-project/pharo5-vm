transformations
bindVariablesIn: aDictionary

	receiver := receiver bindVariablesIn: aDictionary.
	arguments := arguments collect: [ :a | a bindVariablesIn: aDictionary ].