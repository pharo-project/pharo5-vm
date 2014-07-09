sista support
numCountersFor: theCounters
	<var: #theCounters type: #usqInt>
	| objOop |
	theCounters = 0 ifTrue:
		[^0].
	objOop := theCounters - objectMemory baseHeaderSize.
	^2 * (objectMemory numSlotsOf: objOop)