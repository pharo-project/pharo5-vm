spur bootstrap
bootstrapping: aBoolean
	bootstrapping := aBoolean.
	objectMemory ifNotNil:
		[objectMemory bootstrapping: aBoolean]