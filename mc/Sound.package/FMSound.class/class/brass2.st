instruments
brass2
	"FMSound brass2 play"
	"(FMSound lowMajorScaleOn: FMSound brass2) play"

	| snd p env |
	snd := FMSound new modulation: 1 ratio: 1.

	p := OrderedCollection new.
	p add: 0@0.0; add: 20@1.0; add: 40@0.9; add: 100@0.7; add: 160@0.9; add: 200@0.0.
	snd addEnvelope: (VolumeEnvelope points: p loopStart: 3 loopEnd: 5).

	p := OrderedCollection new.
	p add: 0@0.5; add: 30@1.0; add: 40@0.8; add: 100@0.7; add: 160@0.8; add: 200@0.0.
	env := Envelope points: p loopStart: 3 loopEnd: 5.
	env updateSelector: #modulation:; scale: 5.0.
	snd addEnvelope: env.

	^ snd setPitch: 220.0 dur: 1.0 loudness: 0.5
