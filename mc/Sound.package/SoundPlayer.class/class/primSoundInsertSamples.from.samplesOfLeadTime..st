private
primSoundInsertSamples: count from: aSoundBuffer samplesOfLeadTime: anInteger
	"Mix the given number of sample frames from the given sound buffer into the queue of samples that has already been submitted to the sound driver. This primitive is used to start a sound playing with minimum latency, even if large sound output buffers are being used to ensure smooth sound output. Returns the number of samples consumed, or zero if the primitive is not implemented or fails."

	<primitive: 'primitiveSoundInsertSamples' module: 'SoundPlugin'>
	^ 0
