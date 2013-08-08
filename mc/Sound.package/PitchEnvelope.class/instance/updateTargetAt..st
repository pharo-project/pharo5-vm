as yet unclassified
updateTargetAt: mSecs
	"Update the pitch for my target. Answer true if the value changed."
	"Details: Assume envelope range is 0.0..2.0, with 1 being the center pitch. Subtracting one yields the range -1.0..1.0. Raising two to this power yields pitches between half and double the center pitch; i.e. from an octave below to an octave about the center pitch."

	| newValue |
	newValue := self valueAtMSecs: mSecs.
	newValue ~= lastValue ifTrue: [
		target pitch: (2.0 raisedTo: newValue - (scale / 2.0)) * centerPitch.
		lastValue := newValue.
		^ true].

	^ false
