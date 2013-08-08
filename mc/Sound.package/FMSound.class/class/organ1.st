instruments
organ1
	"FMSound organ1 play"
	"(FMSound majorScaleOn: FMSound organ1) play"

	| snd p |
	snd := FMSound new.
	p := OrderedCollection new.
	p add: 0@0; add: 60@1.0; add: 110@0.8; add: 200@1.0; add: 250@0.0.
	snd addEnvelope: (VolumeEnvelope points: p loopStart: 2 loopEnd: 4).
	^ snd setPitch: 440.0 dur: 1.0 loudness: 0.5
