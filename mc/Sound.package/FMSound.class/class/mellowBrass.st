instruments
mellowBrass
	"FMSound mellowBrass play"
	"(FMSound lowMajorScaleOn: FMSound mellowBrass) play"

	| snd p env |
	snd := FMSound new modulation: 0 ratio: 1.

	p := OrderedCollection new.
	p add: 0@0.0; add: 70@0.325; add: 120@0.194; add: 200@0.194; add: 320@0.194; add: 380@0.0.
	snd addEnvelope: (VolumeEnvelope points: p loopStart: 3 loopEnd: 5).

	p := OrderedCollection new.
	p add: 0@0.1; add: 70@0.68; add: 120@0.528; add: 200@0.519; add: 320@0.528; add: 380@0.0.
	env := Envelope points: p loopStart: 3 loopEnd: 5.
	env updateSelector: #modulation:; scale: 5.0.
	snd addEnvelope: env.

	^ snd setPitch: 220.0 dur: 1.0 loudness: 0.5
