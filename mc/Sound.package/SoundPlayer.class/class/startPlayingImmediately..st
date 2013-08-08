private
startPlayingImmediately: aSound
	"Private! Start playing the given sound as soon as possible by mixing it into the sound output buffers of the underlying sound driver."

	| totalSamples buf |
	"first, fill a double-size buffer with samples"
	"Note: The code below assumes that totalSamples contains two
	 buffers worth of samples, and the insertSamples primitive is
	 expected to consume at least one buffer's worth of these
	 samples. The remaining samples are guaranteed to fit into
	 a single buffer."
	totalSamples := Buffer stereoSampleCount * 2.  "two buffer's worth"
	buf := SoundBuffer newStereoSampleCount: totalSamples.
	aSound playSampleCount: totalSamples into: buf startingAt: 1.
	ReverbState == nil ifFalse: [
		ReverbState applyReverbTo: buf startingAt: 1 count: totalSamples].

	PlayerSemaphore critical: [ | n src leftover rest |
		"insert as many samples as possible into the sound driver's buffers"
		n := self primSoundInsertSamples: totalSamples
			from: buf
			samplesOfLeadTime: 1024.
		n > 0 ifTrue:[
			leftover := totalSamples - n.

			"copy the remainder of buf into Buffer"
			"Note: the following loop iterates over 16-bit words, not two-word stereo slices"
			"assert: 0 < leftover <= Buffer stereoSampleCount"
			src := 2 * n.
			1 to: 2 * leftover do:
				[:dst | Buffer at: dst put: (buf at: (src := src + 1))].

			"generate enough additional samples to finish filling Buffer"
			rest := Buffer stereoSampleCount - leftover.
			aSound playSampleCount: rest into: Buffer startingAt: leftover + 1.
			ReverbState == nil ifFalse: [
				ReverbState applyReverbTo: Buffer startingAt: leftover + 1 count: rest].

			"record the fact that this sound has already been played into Buffer so that we don't process it again this time around"
			SoundJustStarted := aSound.
		] ifFalse:[
			"quick start failed; reset the sound so we start over"
			aSound reset.
		].
		ActiveSounds add: aSound].
