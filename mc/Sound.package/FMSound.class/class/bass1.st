instruments
bass1
	"FMSound bass1 play"
	"(FMSound lowMajorScaleOn: FMSound bass1) play"

	| snd |
	snd := FMSound new modulation: 0 ratio: 0.
	snd addEnvelope: (VolumeEnvelope exponentialDecay: 0.95).
	^ snd setPitch: 220 dur: 1.0 loudness: 0.3
