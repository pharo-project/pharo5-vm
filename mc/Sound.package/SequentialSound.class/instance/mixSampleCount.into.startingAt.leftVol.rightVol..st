sound generation
mixSampleCount: n into: aSoundBuffer startingAt: startIndex leftVol: leftVol rightVol: rightVol
	"Play a collection of sounds in sequence."
	"PluckedSound chromaticScale play"

	| finalIndex i snd remaining count |
	currentIndex = 0 ifTrue: [^ self].  "already done"
	finalIndex := (startIndex + n) - 1.
	i := startIndex.
	[i <= finalIndex] whileTrue: [
		snd := (sounds at: currentIndex).
		[(remaining := snd samplesRemaining) <= 0] whileTrue: [
			"find next undone sound"
			currentIndex < sounds size
				ifTrue: [
					currentIndex := currentIndex + 1.
					snd := (sounds at: currentIndex)]
				ifFalse: [
					currentIndex := 0.
					^ self]].  "no more sounds"
		count := (finalIndex - i) + 1.
		remaining < count ifTrue: [count := remaining].
		snd mixSampleCount: count into: aSoundBuffer startingAt: i leftVol: leftVol rightVol: rightVol.
		i := i + count].
