accessing
duration
	"Return the time of the final point."

	loopEndMSecs == nil
		ifTrue: [^ points last x]
		ifFalse: [^ loopEndMSecs + self decayTime].
