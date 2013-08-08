volume
adjustVolumeTo: vol overMSecs: mSecs
	"Adjust the volume of this sound to the given volume, a number in the range [0.0..1.0], over the given number of milliseconds. The volume will be changed a little bit on each sample until the desired volume is reached."

	| newScaledVol |

	self flag: #bob.		"I removed the upper limit to allow making sounds louder. hmm..."

	newScaledVol := (32768.0 * vol) truncated.
	newScaledVol = scaledVol ifTrue: [^ self].
	scaledVolLimit := newScaledVol.
	"scaledVolLimit > ScaleFactor ifTrue: [scaledVolLimit := ScaleFactor]."
	scaledVolLimit < 0 ifTrue: [scaledVolLimit := 0].
	mSecs = 0
		ifTrue: [  "change immediately"
			scaledVol := scaledVolLimit.
			scaledVolIncr := 0]
		ifFalse: [
			scaledVolIncr :=
				((scaledVolLimit - scaledVol) * 1000) // (self samplingRate * mSecs)].
