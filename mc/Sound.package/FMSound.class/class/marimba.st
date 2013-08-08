instruments
marimba
	"FMSound marimba play"
	"(FMSound majorScaleOn: FMSound marimba) play"

	| snd p env |
	snd := FMSound new modulation: 1 ratio: 0.98.

	p := OrderedCollection new.
	p add: 0@1.0; add: 10@0.3; add: 40@0.1; add: 80@0.02; add: 120@0.1; add: 160@0.02; add: 220@0.0.
	snd addEnvelope: (VolumeEnvelope points: p loopStart: 4 loopEnd: 6).

	p := OrderedCollection new.
	p add: 0@1.2; add: 80@0.85; add: 120@1.0; add: 160@0.85; add: 220@0.0.
	env := Envelope points: p loopStart: 2 loopEnd: 4.
	env updateSelector: #modulation:.
	snd addEnvelope: env.

	^ snd setPitch: 220.0 dur: 1.0 loudness: 0.5
