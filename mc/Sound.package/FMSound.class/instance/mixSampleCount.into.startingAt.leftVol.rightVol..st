sound generation
mixSampleCount: n into: aSoundBuffer startingAt: startIndex leftVol: leftVol rightVol: rightVol
	"Play samples from a wave table by stepping a fixed amount through the table on every sample. The table index and increment are scaled to allow fractional increments for greater pitch accuracy."
	"(FMSound pitch: 440.0 dur: 1.0 loudness: 0.5) play"

	| doingFM lastIndex sample offset i s |
	<primitive:'primitiveMixFMSound' module:'SoundGenerationPlugin'>
	
	<var: #aSoundBuffer declareC: 'short int *aSoundBuffer'>
	<var: #waveTable declareC: 'short int *waveTable'>

	doingFM := (normalizedModulation ~= 0) and: [scaledOffsetIndexIncr ~= 0].
	lastIndex := (startIndex + n) - 1.
	startIndex to: lastIndex do: [:sliceIndex |
		sample := (scaledVol * (waveTable at: (scaledIndex // ScaleFactor) + 1)) // ScaleFactor.
		doingFM
			ifTrue: [
				offset := normalizedModulation * (waveTable at: (scaledOffsetIndex // ScaleFactor) + 1).
				scaledOffsetIndex := (scaledOffsetIndex + scaledOffsetIndexIncr) \\ scaledWaveTableSize.
				scaledOffsetIndex < 0
					ifTrue: [scaledOffsetIndex := scaledOffsetIndex + scaledWaveTableSize].
				scaledIndex := (scaledIndex + scaledIndexIncr + offset) \\ scaledWaveTableSize.
				scaledIndex < 0
					ifTrue: [scaledIndex := scaledIndex + scaledWaveTableSize]]
			ifFalse: [
				scaledIndex := (scaledIndex + scaledIndexIncr) \\ scaledWaveTableSize].

		leftVol > 0 ifTrue: [
			i := (2 * sliceIndex) - 1.
			s := (aSoundBuffer at: i) + ((sample * leftVol) // ScaleFactor).
			s >  32767 ifTrue: [s :=  32767].  "clipping!"
			s < -32767 ifTrue: [s := -32767].  "clipping!"
			aSoundBuffer at: i put: s].
		rightVol > 0 ifTrue: [
			i := 2 * sliceIndex.
			s := (aSoundBuffer at: i) + ((sample * rightVol) // ScaleFactor).
			s >  32767 ifTrue: [s :=  32767].  "clipping!"
			s < -32767 ifTrue: [s := -32767].  "clipping!"
			aSoundBuffer at: i put: s].

		scaledVolIncr ~= 0 ifTrue: [
			scaledVol := scaledVol + scaledVolIncr.
			((scaledVolIncr > 0 and: [scaledVol >= scaledVolLimit]) or:
			 [scaledVolIncr < 0 and: [scaledVol <= scaledVolLimit]])
				ifTrue: [  "reached the limit; stop incrementing"
					scaledVol := scaledVolLimit.
					scaledVolIncr := 0]]].

	count := count - n.
