simulation stack
simStackAt: index
	<cmacro: '(index) (simStack + (index))'>
	<returnTypeC: #'CogSimStackEntry *'>
	^self addressOf: (simStack at: index)