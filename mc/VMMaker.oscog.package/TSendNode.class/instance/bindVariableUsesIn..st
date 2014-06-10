transformations
bindVariableUsesIn: aDictionary

	receiver := receiver bindVariableUsesIn: aDictionary.
	arguments := arguments collect: [ :a | a bindVariableUsesIn: aDictionary ].