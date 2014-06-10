primitive support
setInterruptCheckChain: aFunction
	<var: #aFunction declareC: 'void (*aFunction)()'>
	<var: #prevFunction declareC: 'void (*prevFunction)()'>
	<returnTypeC: 'void (*setInterruptCheckChain(void (*aFunction)(void)))()'>
	<export: true>
	| prevFunction |
	prevFunction := interruptCheckChain.
	interruptCheckChain := aFunction.
	^prevFunction