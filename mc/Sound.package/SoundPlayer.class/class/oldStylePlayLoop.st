player process
oldStylePlayLoop
	"This version of the play loop is used if the VM does not yet support sound primitives that signal a semaphore when a sound buffer becomes available."

	| bytesPerSlice count |
	bytesPerSlice := Stereo ifTrue: [4] ifFalse: [2].
	[true] whileTrue: [
		[(count := self primSoundAvailableBytes // bytesPerSlice) > 100]
			whileFalse: [(Delay forMilliseconds: 1) wait].

		count := count min: Buffer stereoSampleCount.
		PlayerSemaphore critical: [
			ActiveSounds := ActiveSounds select: [:snd | snd samplesRemaining > 0].
			ActiveSounds do: [:snd |
				snd ~~ SoundJustStarted ifTrue: [
					snd playSampleCount: count into: Buffer startingAt: 1]].
			ReverbState == nil ifFalse: [
				ReverbState applyReverbTo: Buffer startingAt: 1 count: count].
			self primSoundPlaySamples: count from: Buffer startingAt: 1.
			Buffer primFill: 0.
			SoundJustStarted := nil]].
