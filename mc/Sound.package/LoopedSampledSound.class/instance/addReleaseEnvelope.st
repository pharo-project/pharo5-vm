initialization
addReleaseEnvelope
	"Add a simple release envelope to this sound."

	| p env |
	p := OrderedCollection new.
	p add: 0@1.0; add: 10@1.0; add: 100@1.0; add: 120@0.0.
	env := (VolumeEnvelope points: p loopStart: 2 loopEnd: 3) target: self.
	envelopes size > 0 ifTrue: [  "remove any existing volume envelopes"
		envelopes copy do: [:e |
			(e isKindOf: VolumeEnvelope) ifTrue: [self removeEnvelope: e]]].
	self addEnvelope: env.
