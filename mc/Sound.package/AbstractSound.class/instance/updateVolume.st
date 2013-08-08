sound generation
updateVolume
	"Increment the volume envelope of this sound. To avoid clicks, the volume envelope must be interpolated at the sampling rate, rather than just at the control rate like other envelopes. At the control rate, the volume envelope computes the slope and next target volume volume for the current segment of the envelope (i.e., it sets the rate of change for the volume parameter). When that target volume is reached, incrementing is stopped until a new increment is set."
	"This method is provided for documentation. To gain 10% more speed when running sound generation in Smalltalk, it is hand-inlined into all sound generation methods that use it."

		scaledVolIncr ~= 0 ifTrue: [
			scaledVol := scaledVol + scaledVolIncr.
			((scaledVolIncr > 0 and: [scaledVol >= scaledVolLimit]) or:
			 [scaledVolIncr < 0 and: [scaledVol <= scaledVolLimit]])
				ifTrue: [  "reached the limit; stop incrementing"
					scaledVol := scaledVolLimit.
					scaledVolIncr := 0]].
