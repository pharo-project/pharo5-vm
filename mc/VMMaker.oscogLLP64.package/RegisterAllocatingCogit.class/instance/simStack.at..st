simulation stack
simStack: stack at: index
	<cmacro: '(stack,index) ((stack) + (index))'>
	<returnTypeC: #'CogSimStackEntry *'>
	^self addressOf: (stack at: index)