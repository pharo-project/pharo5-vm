instruments
default
	"PluckedSound default play"
	"(AbstractSound majorScaleOn: PluckedSound default) play"

	| snd p env |
	snd := PluckedSound new.
	p := OrderedCollection new.
	p add: 0@1.0; add: 10@1.0; add: 20@0.0.
	env := VolumeEnvelope points: p loopStart: 2 loopEnd: 2.
	env target: snd; scale: 0.3.
	^ snd
		addEnvelope: env;
		setPitch: 220 dur: 3.0 loudness: 0.3
