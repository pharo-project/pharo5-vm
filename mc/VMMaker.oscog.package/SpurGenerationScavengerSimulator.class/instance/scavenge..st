scavenger
scavenge: tenuringCriterion
	manager bootstrapping ifFalse:
		[coInterpreter transcript nextPutAll: 'scavenging('; print: manager statScavenges; nextPutAll: ')...'; flush].
	^super scavenge: tenuringCriterion