instruments
bassoon1
	"FMSound bassoon1 play"
	"(FMSound lowMajorScaleOn: FMSound bassoon1) play"

	| snd p env |
	snd := FMBassoonSound new ratio: 1.

	p := OrderedCollection new.
	p add: 0@0.0; add: 40@0.45; add: 90@1.0; add: 180@0.9; add: 270@1.0; add: 320@0.0.
	snd addEnvelope: (VolumeEnvelope points: p loopStart: 3 loopEnd: 5).

	p := OrderedCollection new.
	p add: 0@0.2; add: 40@0.9; add: 90@0.6; add: 270@0.6; add: 320@0.5.
	env := Envelope points: p loopStart: 3 loopEnd: 4.
	env updateSelector: #modulation:; scale: 5.05.
	snd addEnvelope: env.

	^ snd setPitch: 220.0 dur: 1.0 loudness: 0.5
