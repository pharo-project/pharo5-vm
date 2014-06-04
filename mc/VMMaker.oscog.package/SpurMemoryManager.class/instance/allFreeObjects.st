free space
allFreeObjects
	<doNotGenerate>
	| freeObjects |
	freeObjects := OrderedCollection new.
	self allFreeObjectsDo:
		[:f| freeObjects addLast: f].
	^freeObjects