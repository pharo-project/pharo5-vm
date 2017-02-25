simulation stack
simStack: aSimStack isIdenticalTo: bSimStack
	<var: 'aSimStack' type: #'SimStackEntry *'>
	<var: 'bSimStack' type: #'SimStackEntry *'>
	0 to: simStackPtr do:
		[:i|
		((self simStack: aSimStack at: i) isIdenticalEntryAs: (self simStack: bSimStack at: i)) ifFalse:
			[^false]].
	^true