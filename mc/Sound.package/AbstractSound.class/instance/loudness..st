initialization
loudness: aNumber
	"Initialize my volume envelopes and initial volume. Subclasses overriding this method should include a resend to super."

	| vol |
	vol := (aNumber asFloat max: 0.0) min: 1.0.
	envelopes do: [:e |
		(e isKindOf: VolumeEnvelope) ifTrue: [e scale: vol]].
	self initialVolume: vol.
