I/O primitives support
queueForwardedEvent: event
	eventQueue ifNil:
		[eventQueue := SharedQueue new].
	eventQueue nextPut: event