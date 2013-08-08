instruments
brass1
	"FMSound brass1 play"
	"(FMSound lowMajorScaleOn: FMSound brass1) play"

	| snd p env |
	snd := FMSound new modulation: 0 ratio: 1.
	p := OrderedCollection new.
	p add: 0@0.0; add: 30@0.8; add: 90@1.0; add: 120@0.9; add: 220@0.7; add: 320@0.9; add: 360@0.0.
	snd addEnvelope: (VolumeEnvelope points: p loopStart: 4 loopEnd: 6).

	p := OrderedCollection new.
	p add: 0@0.5; add: 60@1.0; add: 120@0.8; add: 220@0.65; add: 320@0.8; add: 360@0.0.
	env := Envelope points: p loopStart: 3 loopEnd: 5.
	env target: snd; updateSelector: #modulation:; scale: 5.0.
	snd addEnvelope: env.

	^ snd setPitch: 220.0 dur: 1.0 loudness: 0.5
