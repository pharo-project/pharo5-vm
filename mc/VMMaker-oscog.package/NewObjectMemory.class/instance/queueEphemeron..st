ephemerons
queueEphemeron: oop

	"add ephemeron to queue"
	<inline: true>
	self storePointerUnchecked: 1 ofObject: oop withValue: ephemeronsQueue.
	ephemeronsQueue := oop.

	