processing-voice
voicedPitchSynchronousReset
	<returnTypeC: 'void'>

	"Set the pitch."
	pitch := frame at: F0.

	"Add flutter and jitter (F0 perturbations)."
	self addFlutter.
	self addJitter.
	self addFrequencyDiplophonia.
	pitch < 0 ifTrue: [pitch := 0].

	"Recompute t0 (it is the number of samples in one pitch period)."
	t0 := (samplingRate / pitch) asInteger.

	"Duration of period before amplitude modulation."
	nmod := t0.
	(frame at: Voicing) > 0 ifTrue: [nmod := nmod // 2].

	"Set open phase of glottal period."
	nopen := (t0 * (frame at: Ro)) asInteger.

	"Set the LF glottal pulse model parameters."
	self ro: (frame at: Ro) ra: (frame at: Ra) rk: (frame at: Rk).

	"Add shimmer and diplophonia amplitude pertirbations.
	(This must be done AFTER the actual computation of the LF parameters.)"
	self addShimmer.
	self addAmplitudeDiplophonia