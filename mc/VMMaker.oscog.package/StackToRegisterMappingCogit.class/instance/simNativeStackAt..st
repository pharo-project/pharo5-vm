simulation stack
simNativeStackAt: index
	<cmacro: '(index) (simNativeStack + (index))'>
	<returnTypeC: #'CogSimStackNativeEntry *'>
	^self addressOf: (simNativeStack at: index)