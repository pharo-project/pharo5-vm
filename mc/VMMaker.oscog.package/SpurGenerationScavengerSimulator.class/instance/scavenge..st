scavenger
scavenge: tenuringCriterion
	manager bootstrapping ifFalse:
		[coInterpreter transcript nextPutAll: 'scavenging('; print: manager statScavenges; nextPutAll: ')...'; flush.
		 cameFrom ifNotNil:
			[cameFrom := Dictionary new]].
	^super scavenge: tenuringCriterion