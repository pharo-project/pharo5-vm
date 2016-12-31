initialize-release
close  "close any sockets that ST may have opened"
	openSocketHandles do: [:h | self closeAndDestroy: h].
	Smalltalk unregisterExternalObjects: externalSemaphores