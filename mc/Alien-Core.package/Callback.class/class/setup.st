class initialization
setup
	"Callback setup"
	| prevMap |
	FlushThunkToCallbackMap := false.
	(WeakArray hasWeakDependent: self) ifFalse:
		[WeakArray addWeakDependent: self].
	prevMap := ThunkToCallbackMap.
	ThunkToCallbackMap := WeakValueDictionary new.
	prevMap notNil ifTrue:
		[prevMap keysAndValuesDo:
			[:thunkAddress :callback|
			ThunkToCallbackMap at: thunkAddress put: callback]]