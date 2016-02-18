munging
mapPCs
	| cbc cmc |
	cmc := 36.
	cbc := 37.
	heap allObjectsDo:
		[:obj| | ci |
		ci := heap classIndexOf: obj.
		(ci <= 37 and: [ci >= 36]) ifTrue:
			[ci = 37 ifTrue: [self mungeClosure: obj].
			 ci = 36 ifTrue: [self mungeContext: obj]]]