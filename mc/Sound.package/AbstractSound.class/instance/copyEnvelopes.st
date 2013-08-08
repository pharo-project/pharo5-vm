copying
copyEnvelopes
	"Private! Support for copying. Copy my envelopes."

	envelopes := envelopes collect: [:e | e copy target: self].
