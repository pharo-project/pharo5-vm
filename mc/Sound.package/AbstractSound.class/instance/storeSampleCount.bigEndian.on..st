file i/o
storeSampleCount: samplesToStore bigEndian: bigEndianFlag on: aBinaryStream
	"Store my samples on the given stream at the current SoundPlayer sampling rate. If bigFlag is true, then each 16-bit sample is stored most-significant byte first (AIFF files), otherwise it is stored least-significant byte first (WAV files). If self isStereo is true, both channels are stored, creating a stereo file. Otherwise, only the left channel is stored, creating a mono file."

	| bufSize stereoBuffer reverseBytes |
	self reset.
	bufSize := (2 * self samplingRate rounded) min: samplesToStore.  "two second buffer"
	stereoBuffer := SoundBuffer newStereoSampleCount: bufSize.
	reverseBytes := bigEndianFlag ~= (SmalltalkImage current isBigEndian).

	'Storing audio...'
		displayProgressAt: Sensor cursorPoint
		from: 0 to: samplesToStore during: [:bar | | remaining out |
			remaining := samplesToStore.
			[remaining > 0] whileTrue: [
				bar value: samplesToStore - remaining.
				stereoBuffer primFill: 0.  "clear the buffer"
				self playSampleCount: (bufSize min: remaining) into: stereoBuffer startingAt: 1.
				out := self isStereo
						ifTrue: [stereoBuffer]
						ifFalse: [stereoBuffer extractLeftChannel].
				reverseBytes ifTrue: [out reverseEndianness].
				(aBinaryStream isKindOf: StandardFileStream)
					ifTrue: [  "optimization for files: write sound buffer directly to file"
						aBinaryStream next: (out size // 2) putAll: out startingAt: 1]  "size in words"
					ifFalse: [  "for non-file streams:"
						1 to: out monoSampleCount do: [:i | aBinaryStream int16: (out at: i)]].
				remaining := remaining - bufSize]].
