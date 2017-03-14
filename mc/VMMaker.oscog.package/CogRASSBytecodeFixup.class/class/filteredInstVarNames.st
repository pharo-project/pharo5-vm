translation
filteredInstVarNames
	"Override to group char and short vars together for compactness.
	 self typedef"
	| vars |
	vars := super filteredInstVarNames asOrderedCollection.
	vars
		remove: 'mergeSimStack';
		add: 'mergeSimStack' afterIndex: (vars indexOf: 'targetInstruction');
		remove: 'isReceiverResultRegSelf';
		add: 'isReceiverResultRegSelf' afterIndex: (vars indexOf: 'simStackPtr').
	^vars