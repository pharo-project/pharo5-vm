object memory support
postGCAction: gcModeArg
	"Signal the gc semaphore"

	self signalSemaphoreWithIndex: gcSemaphoreIndex