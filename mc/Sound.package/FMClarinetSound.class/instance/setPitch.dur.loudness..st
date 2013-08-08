initialization
setPitch: pitchNameOrNumber dur: d loudness: l
	"Select a modulation ratio and modulation envelope scale based on my pitch."

	| p modScale |
	p := self nameOrNumberToPitch: pitchNameOrNumber.
	p < 262.0
		ifTrue: [modScale := 25.0. self ratio: 4]
		ifFalse: [modScale := 20.0. self ratio: 2].
	p > 524.0 ifTrue: [modScale := 8.0].

	envelopes size > 0 ifTrue: [
		envelopes do: [:e |
			(e updateSelector = #modulation:)
				ifTrue: [e scale: modScale]]].

	super setPitch: p dur: d loudness: l.
