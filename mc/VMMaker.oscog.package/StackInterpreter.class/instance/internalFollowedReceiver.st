internal interpreter access
internalFollowedReceiver
	<inline: true>
	| rcvr |
	rcvr := stackPages longAt: localFP + FoxReceiver.
	(objectMemory isOopForwarded: rcvr) ifTrue:
		[rcvr := objectMemory followForwarded: rcvr.
		 stackPages longAt: localFP + FoxReceiver put: rcvr].
	^rcvr