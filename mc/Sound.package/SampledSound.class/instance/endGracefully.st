playing
endGracefully
	"See stopGracefully, which affects initialCOunt, and I don't think it should (di)."

	| decayInMs env |
	envelopes isEmpty
		ifTrue: [
			self adjustVolumeTo: 0 overMSecs: 10.
			decayInMs := 10]
		ifFalse: [
			env := envelopes first.
			decayInMs := env attackTime + env decayTime].
	count := decayInMs * self samplingRate // 1000.
