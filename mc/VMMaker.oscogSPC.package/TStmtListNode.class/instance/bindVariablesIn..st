transformations
bindVariablesIn: aDictionary

	statements := statements collect: [ :s | s bindVariablesIn: aDictionary ].