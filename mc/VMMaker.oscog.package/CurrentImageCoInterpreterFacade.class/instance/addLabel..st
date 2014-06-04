labels
addLabel: l
	(variables includesKey: l) ifFalse:
		[variables at: l put: variables size * 4 + 65536]