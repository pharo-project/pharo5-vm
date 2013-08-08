sound generation
reset
	"Reset my internal state for a replay. Methods that override this method should do super reset."

	mSecsSinceStart := 0.
	samplesUntilNextControl := 0.
	envelopes size > 0 ifTrue: [
		1 to: envelopes size do: [:i | (envelopes at: i) reset]].
