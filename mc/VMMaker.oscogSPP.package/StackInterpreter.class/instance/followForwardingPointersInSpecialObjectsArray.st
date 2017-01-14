object memory support
followForwardingPointersInSpecialObjectsArray
	"Various semaphores in the specialObjectsArray are signalled in checkForEventsMayContextSwitch:.
	 These must be followed post become to avoid a read barrier in checkForEventsMayContextSwitch:,
	 or worse still in synchronousSignal."
	| xArray |
	self followSemaphoreIn: objectMemory specialObjectsOop
		at: TheLowSpaceSemaphore.
	self followSemaphoreIn: objectMemory specialObjectsOop
		at: TheInterruptSemaphore.
	self followSemaphoreIn: objectMemory specialObjectsOop
		at: TheTimerSemaphore.
	self followSemaphoreIn: objectMemory specialObjectsOop
		at: TheFinalizationSemaphore.
	xArray := objectMemory splObj: ExternalObjectsArray.
	(objectMemory isForwarded: xArray) ifTrue:
		[xArray := objectMemory followForwarded: xArray.
		 objectMemory splObj: ExternalObjectsArray put: xArray].
	0 to: (objectMemory numSlotsOf: xArray) - 1 do:
		[:i|
		self followSemaphoreIn: xArray at: i]