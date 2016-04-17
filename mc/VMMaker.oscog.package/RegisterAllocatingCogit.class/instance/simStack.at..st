simulation stack
simStack: stack at: index
	<cmacro: '(index) (stack + (index))'>
	<returnTypeC: #'CogSimStackEntry *'>
	^self addressOf: (stack at: index)