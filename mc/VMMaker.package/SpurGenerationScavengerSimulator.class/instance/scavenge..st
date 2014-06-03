scavenger
scavenge: tenuringCriterion
	coInterpreter transcript nextPutAll: 'scavenging('; print: manager statScavenges; nextPutAll: ')...'; flush.
	^super scavenge: tenuringCriterion