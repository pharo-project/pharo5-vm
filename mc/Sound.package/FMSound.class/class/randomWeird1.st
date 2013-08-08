instruments
randomWeird1
	"FMSound randomWeird1 play"

	| snd p |
	snd := FMSound new.
	snd addEnvelope: (VolumeEnvelope exponentialDecay: 0.96).
	p := Array with: 0@0 with: 100@1.0 with: 250@0.7 with: 400@1.0 with: 500@0.
	snd addEnvelope: (PitchEnvelope points: p loopStart: 2 loopEnd: 4).
	^ snd setPitch: (150 + 2000 atRandom) dur: 2.0 loudness: 0.5
