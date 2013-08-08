ephemerons
nextEphemeron: oop

	"answer the next ephemeron from queue (see symmetric #queueEphemeron)"
	<inline: true>
	^ self fetchPointer: 1 ofObject: oop

	