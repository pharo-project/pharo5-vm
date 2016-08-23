debug support
numberOfForwarders
	| n |
	n := 0.
	self allHeapEntitiesDo:
		[:o|
		(self isUnambiguouslyForwarder: o) ifTrue:
			[n := n + 1]].
	^n