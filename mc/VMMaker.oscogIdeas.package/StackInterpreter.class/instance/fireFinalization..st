finalization
fireFinalization: weakling
	<option: #SpurObjectMemory>
	newFinalization ifTrue:
		[objectMemory queueMourner: weakling].
	self signalFinalization: weakling