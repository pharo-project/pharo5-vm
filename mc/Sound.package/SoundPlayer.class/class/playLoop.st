player process
playLoop
	"The sound player process loop."

	| bytesPerSlice count willStop mayStop |
	mayStop := self stopSoundWhenDone.
	bytesPerSlice := Stereo ifTrue: [4] ifFalse: [2].
	[true] whileTrue: [
		[(count := self primSoundAvailableBytes // bytesPerSlice) > 100]
			whileFalse: [ReadyForBuffer wait].

		count := count min: Buffer stereoSampleCount.
		PlayerSemaphore critical: [
			ActiveSounds := ActiveSounds select: [:snd | snd samplesRemaining > 0].
			ActiveSounds do: [:snd |
				snd ~~ SoundJustStarted ifTrue: [
					snd playSampleCount: count into: Buffer startingAt: 1]].
			ReverbState == nil ifFalse: [
				ReverbState applyReverbTo: Buffer startingAt: 1 count: count].
			self primSoundPlaySamples: count from: Buffer startingAt: 1.
			willStop := mayStop and:[
						(ActiveSounds size = 0) and:[
							self isAllSilence: Buffer size: count]].
			LastBuffer ifNotNil:[
				LastBuffer replaceFrom: 1 to: LastBuffer size with: Buffer startingAt: 1.
			].
			willStop
				ifTrue:[self shutDown. PlayerProcess := nil]
				ifFalse:[Buffer primFill: 0].
			SoundJustStarted := nil].
		willStop ifTrue:[^self].
	].
