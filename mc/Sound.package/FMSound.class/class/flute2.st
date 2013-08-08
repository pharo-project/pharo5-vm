instruments
flute2
	"FMSound flute2 play"
	"(FMSound majorScaleOn: FMSound flute2) play"

	| snd p |
	snd := FMSound new.
	p := OrderedCollection new.
	p add: 0@0; add: 20@1.0; add: 100@1.0; add: 120@0.0.
	snd addEnvelope: (VolumeEnvelope points: p loopStart: 2 loopEnd: 3).
	snd addEnvelope: (RandomEnvelope for: #pitch:).
	^ snd setPitch: 440.0 dur: 1.0 loudness: 0.5
