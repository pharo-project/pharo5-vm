instruments
pluckedElecBass
	"FMSound pluckedElecBass play"
	"(FMSound lowMajorScaleOn: FMSound pluckedElecBass) play"

	| snd p env |
	snd := FMSound new modulation: 1 ratio: 3.0.

	p := OrderedCollection new.
	p add: 0@0.4; add: 20@1.0; add: 30@0.6; add: 100@0.6; add: 130@0.0.
	snd addEnvelope: (VolumeEnvelope points: p loopStart: 3 loopEnd: 4).

	p := OrderedCollection new.
	p add: 0@1.0; add: 20@2.0; add: 30@4.5; add: 100@4.5; add: 130@0.0.
	env := Envelope points: p loopStart: 3 loopEnd: 4.
	env updateSelector: #modulation:.
	snd addEnvelope: env.

	p := OrderedCollection new.
	p add: 0@6.0; add: 20@4.0; add: 30@3.0; add: 100@3.0; add: 130@3.0.
	env := Envelope points: p loopStart: 3 loopEnd: 4.
	env updateSelector: #ratio:.
	snd addEnvelope: env.

	^ snd setPitch: 220.0 dur: 1.0 loudness: 0.5
