initialization
setPitch: pitchNameOrNumber dur: d loudness: l
	"Initialize my envelopes for the given parameters. Subclasses overriding this method should include a resend to super."

	| p |
	p := self nameOrNumberToPitch: pitchNameOrNumber.
	envelopes do: [:e |
		e volume: l.
		e centerPitch: p].
	self initialVolume: l.
	self duration: d.
