playing
samples
	"Answer a monophonic sample buffer containing my samples. The left and write channels are merged."
	"Warning: This may require a lot of memory!"

	^ (self computeSamplesForSeconds: self duration) mergeStereo
