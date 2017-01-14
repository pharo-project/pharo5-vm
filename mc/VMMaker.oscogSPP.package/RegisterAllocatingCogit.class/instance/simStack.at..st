simulation stack
simStack: stack at: index
	<cmacro: '(stack,index) ((stack) + (index))'>
	<returnTypeC: #'SimStackEntry *'>
	^self addressOf: (stack at: index)