instruments
randomWeird2
	"FMSound randomWeird2 play"

	| snd |
	snd := FMSound new.
	snd addEnvelope: (VolumeEnvelope exponentialDecay: 0.96).
	snd addEnvelope: (PitchEnvelope exponentialDecay: 0.98).
	^ snd setPitch: (150 + 2000 atRandom) dur: 2.0 loudness: 0.5
