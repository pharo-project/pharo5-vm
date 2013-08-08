sound generation
mixSampleCount: n into: aSoundBuffer startingAt: startIndex leftVol: leftVol rightVol: rightVol
	"The Karplus-Strong plucked string algorithm: start with a buffer full of random noise and repeatedly play the contents of that buffer while averaging adjacent samples. High harmonics damp out more quickly, transfering their energy to lower ones. The length of the buffer corresponds to the length of the string."
	"(PluckedSound pitch: 220.0 dur: 6.0 loudness: 0.8) play"

	| lastIndex scaledThisIndex scaledNextIndex average sample i s |
	<primitive:'primitiveMixPluckedSound' module:'SoundGenerationPlugin'>
	
	<var: #aSoundBuffer declareC: 'short int *aSoundBuffer'>
	<var: #ring declareC: 'short int *ring'>

	lastIndex := (startIndex + n) - 1.
	scaledThisIndex := scaledNextIndex := scaledIndex.
	startIndex to: lastIndex do: [:sliceIndex |
		scaledNextIndex := scaledThisIndex + scaledIndexIncr.
		scaledNextIndex >= scaledIndexLimit
			ifTrue: [scaledNextIndex := ScaleFactor + (scaledNextIndex - scaledIndexLimit)].
		average :=
			((ring at: scaledThisIndex // ScaleFactor) +
			 (ring at: scaledNextIndex // ScaleFactor)) // 2.
		ring at: scaledThisIndex // ScaleFactor put: average.
		sample := (average * scaledVol) // ScaleFactor.  "scale by volume"
		scaledThisIndex := scaledNextIndex.

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

	scaledIndex := scaledNextIndex.
	count := count - n.
