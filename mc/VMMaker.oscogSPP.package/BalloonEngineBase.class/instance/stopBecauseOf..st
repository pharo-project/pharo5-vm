other
stopBecauseOf: stopReason
	self stopReasonPut: stopReason.
	engineStopped := true.