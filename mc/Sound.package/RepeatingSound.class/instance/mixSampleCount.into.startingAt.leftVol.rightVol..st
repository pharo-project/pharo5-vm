sound generation
mixSampleCount: n into: aSoundBuffer startingAt: startIndex leftVol: leftVol rightVol: rightVol
	"Play a collection of sounds in sequence."
	"(RepeatingSound new
		setSound: FMSound majorScale
		iterations: 2) play"

	| i count samplesNeeded |
	iteration <= 0 ifTrue: [^ self].
	i := startIndex.
	samplesNeeded := n.
	[samplesNeeded > 0] whileTrue: [
		count := sound samplesRemaining min: samplesNeeded.
		count = 0 ifTrue: [
			iterationCount == #forever
				ifFalse: [
					iteration := iteration - 1.
					iteration <= 0 ifTrue: [^ self]].  "done"
			sound reset.
			count := sound samplesRemaining min: samplesNeeded.
			count = 0 ifTrue: [^ self]].  "zero length sound"
		sound mixSampleCount: count
			into: aSoundBuffer
			startingAt: i
			leftVol: leftVol
			rightVol: rightVol.
		i := i + count.
		samplesNeeded := samplesNeeded - count].
