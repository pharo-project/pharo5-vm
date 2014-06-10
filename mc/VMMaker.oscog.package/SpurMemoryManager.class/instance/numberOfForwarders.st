debug support
numberOfForwarders
	| n |
	n := 0.
	self allHeapEntitiesDo:
		[:o|
		(self isForwarded: o) ifTrue:
			[n := n + 1]].
	^n