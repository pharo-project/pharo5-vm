simulation
stopBecauseOf: stopReason
	"Don't stop because of need to flush."
	stopReason = GErrorNeedFlush ifFalse:[
		^super stopBecauseOf: stopReason.
	].