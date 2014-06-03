accessing
labels: aCollection

	labels := aCollection isSequenceable
				ifTrue: [aCollection asOrderedCollection]
				ifFalse: [aCollection asSortedCollection asOrderedCollection]