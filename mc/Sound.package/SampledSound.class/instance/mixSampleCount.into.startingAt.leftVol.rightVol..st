playing
mixSampleCount: n into: aSoundBuffer startingAt: startIndex leftVol: leftVol rightVol: rightVol
	"Mix the given number of samples with the samples already in the given buffer starting at the given index. Assume that the buffer size is at least (index + count) - 1."

	| lastIndex outIndex sampleIndex sample i s overflow |
	<primitive:'primitiveMixSampledSound' module:'SoundGenerationPlugin'>
	
	<var: #aSoundBuffer declareC: 'short int *aSoundBuffer'>
	<var: #samples declareC: 'short int *samples'>

	lastIndex := (startIndex + n) - 1.
	outIndex := startIndex.    "index of next stereo output sample pair"
	sampleIndex := indexHighBits + (scaledIndex >> IncrementFractionBits).
	[(sampleIndex <= samplesSize) and: [outIndex <= lastIndex]] whileTrue: [
		sample := ((samples at: sampleIndex) * scaledVol) // ScaleFactor.
		leftVol > 0 ifTrue: [
			i := (2 * outIndex) - 1.
			s := (aSoundBuffer at: i) + ((sample * leftVol) // ScaleFactor).
			s >  32767 ifTrue: [s :=  32767].  "clipping!"
			s < -32767 ifTrue: [s := -32767].  "clipping!"
			aSoundBuffer at: i put: s].
		rightVol > 0 ifTrue: [
			i := 2 * outIndex.
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
					scaledVolIncr := 0]].

		scaledIndex := scaledIndex + scaledIncrement.
		scaledIndex >= ScaledIndexOverflow ifTrue: [
			overflow := scaledIndex >> IncrementFractionBits.
			indexHighBits := indexHighBits + overflow.
			scaledIndex := scaledIndex - (overflow << IncrementFractionBits)].

		sampleIndex := indexHighBits + (scaledIndex >> IncrementFractionBits).
		outIndex := outIndex + 1].
	count := count - n.
