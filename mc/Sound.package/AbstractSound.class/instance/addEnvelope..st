envelopes
addEnvelope: anEnvelope
	"Add the given envelope to my envelopes list."

	anEnvelope target: self.
	envelopes := envelopes copyWith: anEnvelope.
