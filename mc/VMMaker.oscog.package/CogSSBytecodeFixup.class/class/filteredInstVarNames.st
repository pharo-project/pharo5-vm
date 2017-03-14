translation
filteredInstVarNames
	"Override to add ifdef LowcodeVM around the native stack info, and to put
	 char vars before short vars.
	 self typedef"
	| vars |
	vars := super filteredInstVarNames asOrderedCollection.
	vars
		remove: 'instructionIndex';
		add: 'instructionIndex' afterIndex: (vars indexOf: 'simStackPtr');
		add: '#if LowcodeVM' beforeIndex: (vars indexOf: 'simNativeStackPtr');
		add: '#endif' afterIndex: (vars indexOf: 'simNativeStackSize').
	^vars