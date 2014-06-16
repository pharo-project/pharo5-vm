debug support
numberOfForwarders
	| n |
	n := 0.
	self allHeapEntitiesDo:
		[:o|
		((self isForwarded: o) and: [(self isFreeObject: o) not]) ifTrue:
			[n := n + 1]].
	^n