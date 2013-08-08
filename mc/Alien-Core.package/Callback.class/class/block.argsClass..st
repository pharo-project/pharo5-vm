instance creation
block: aBlock "<BlockContext>" argsClass: argsProxyClass "<Alien class>" "^<Callback>"
	"Answer a Callback that evaluates aBlock and whose thunk should conform to the C calling convention."
	^self new
		block: aBlock
		thunk: FFICallbackThunk newCCall
		argsProxy: argsProxyClass newForCallbackArgs