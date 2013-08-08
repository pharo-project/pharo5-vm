instruments
oboe2
	"FMSound oboe2 play"
	"(FMSound majorScaleOn: FMSound oboe2) play"

	| snd p |
	snd := FMSound new modulation: 1 ratio: 1.
	p := OrderedCollection new.
	p add: 0@0; add: 20@1.0; add: 100@1.0; add: 120@0.0.
	snd addEnvelope: (VolumeEnvelope points: p loopStart: 2 loopEnd: 3).
	snd addEnvelope: (RandomEnvelope for: #pitch:).
	^ snd setPitch: 440.0 dur: 1.0 loudness: 0.5
