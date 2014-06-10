accessing
addLast: element
	| newLast |
	newLast := last + manager wordSize.
	newLast >= limit ifTrue:
		[newLast := start].
	(newLast = first and: [last >= start]) ifTrue: "wrapped; bump first"
		[(first := newLast + manager wordSize) >= limit ifTrue:
			[first := start]].
	last := newLast.
	self assert: (first >= start and: [first < limit]).
	self assert: (last >= start and: [last < limit]).
	manager longAt: newLast put: element