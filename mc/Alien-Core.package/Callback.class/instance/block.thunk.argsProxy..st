instance initialization
block: aBlock "<BlockContext>" thunk: thunkWrapper "<FFICallbackThunk>" argsProxy: argsWrapper "<Alien>"
	block := aBlock.
	thunk := thunkWrapper.
	argsProxy := argsWrapper.
	resultProxy := FFICallbackReturnValue new.
	FlushThunkToCallbackMap ifTrue:
		[FlushThunkToCallbackMap := false.
		 ThunkToCallbackMap keys do:
			[:k| (ThunkToCallbackMap at: k) ifNil: [ThunkToCallbackMap removeKey: k]]].
	ThunkToCallbackMap at: thunk addressField put: self