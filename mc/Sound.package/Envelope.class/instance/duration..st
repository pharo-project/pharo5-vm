accessing
duration: seconds
	"Set the note duration to the given number of seconds."
	"Details: The duration is reduced by 19 mSec to ensure proper cutoffs even when the sound starts playing between doControl epochs."
	"Note: This is a hack. With a little additional work on the envelope logic, it should be possible to reduce or eliminate this fudge factor. In particular, an envelope should use the time remaining, rather than time-since-start to determine when to enter its decay phase. In addition, an envelope must be able to cut off in minimum time (~5-10 msec) if there isn't enough time to do their normal decay. All of this is to allow instruments with leisurely decays to play very short notes if necessary (say, when fast-forwarding through a score)." 

	| attack decay endTime |
	endMSecs := (seconds * 1000.0) asInteger - 19.
	attack := self attackTime.
	decay := self decayTime.
	endMSecs > (attack + decay)
		ifTrue: [endTime := endMSecs - decay]
		ifFalse: [
			endMSecs >= attack
				ifTrue: [endTime := attack]
				ifFalse: [endTime := endMSecs]].

	self sustainEnd: (endTime max: 0).
