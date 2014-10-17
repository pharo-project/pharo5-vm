helper
createTimer: name
	"Create and register a new timer for the current benchmark"
	| timer |
	timer := self class defaultTimer new: name.
	
	timers ifNotNil: [
		timers at: name put: timer.
	].
	
	^ timer.