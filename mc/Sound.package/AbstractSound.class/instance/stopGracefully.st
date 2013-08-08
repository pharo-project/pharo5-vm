sound generation
stopGracefully
	"End this note with a graceful decay. If the note has envelopes, determine the decay time from its envelopes."

	| decayInMs env |
	envelopes isEmpty
		ifTrue: [
			self adjustVolumeTo: 0 overMSecs: 10.
			decayInMs := 10]
		ifFalse: [
			env := envelopes first.
			decayInMs := env attackTime + env decayTime].
	self duration: (mSecsSinceStart + decayInMs) / 1000.0.
	self stopAfterMSecs: decayInMs.
