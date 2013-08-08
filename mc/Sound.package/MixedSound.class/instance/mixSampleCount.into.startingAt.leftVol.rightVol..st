sound generation
mixSampleCount: n into: aSoundBuffer startingAt: startIndex leftVol: leftVol rightVol: rightVol
	"Play a number of sounds concurrently. The level of each sound can be set independently for the left and right channels."

	| snd left right |
	1 to: sounds size do: [:i |
		(soundDone at: i) ifFalse: [
			snd := sounds at: i.
			left := (leftVol * (leftVols at: i)) // ScaleFactor.
			right := (rightVol * (rightVols at: i)) // ScaleFactor.
			snd samplesRemaining > 0
				ifTrue: [
					snd mixSampleCount: n into: aSoundBuffer startingAt: startIndex leftVol: left rightVol: right]
				ifFalse: [soundDone at: i put: true]]].
