transformations
bindVariablesIn: aDictionary 
	^ (aDictionary at: name ifAbsent: [^ self]) copy