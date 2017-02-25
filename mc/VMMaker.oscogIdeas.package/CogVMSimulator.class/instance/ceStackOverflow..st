trampolines
ceStackOverflow: contextSwitchIfNotNil
	"Override to bump up the byteCount from which the microsecond clock is derived."
	byteCount := byteCount + 1000.
	^super ceStackOverflow: contextSwitchIfNotNil