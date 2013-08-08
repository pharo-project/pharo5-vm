envelopes
removeEnvelope: anEnvelope
	"Remove the given envelope from my envelopes list."

	envelopes := envelopes copyWithout: anEnvelope.
