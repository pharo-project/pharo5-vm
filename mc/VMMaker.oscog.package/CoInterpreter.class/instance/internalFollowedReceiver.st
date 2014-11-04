internal interpreter access
internalFollowedReceiver
	<inline: true>
	| rcvr |
	rcvr := stackPages longAt: localFP + FoxIFReceiver.
	(objectMemory isOopForwarded: rcvr) ifTrue:
		[rcvr := objectMemory followForwarded: rcvr.
		 stackPages longAt: localFP + FoxIFReceiver put: rcvr].
	^rcvr