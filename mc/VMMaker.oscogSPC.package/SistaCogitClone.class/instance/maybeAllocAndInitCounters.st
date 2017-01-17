compile abstract instructions
maybeAllocAndInitCounters
	<inline: true>
	self assert: counters = 0.
	counterIndex := 0.
	numCounters = 0 ifTrue:
		[^true].
	counters := objectRepresentation allocateCounters: numCounters.
	^counters ~= 0