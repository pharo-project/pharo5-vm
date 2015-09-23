labels
addLabel: l
	(variables includesKey: l) ifFalse:
		[variables at: l put: variables size * objectMemory wordSize + 65536]