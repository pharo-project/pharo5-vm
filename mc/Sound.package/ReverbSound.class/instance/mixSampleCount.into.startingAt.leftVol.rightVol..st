sound generation
mixSampleCount: n into: aSoundBuffer startingAt: startIndex leftVol: leftVol rightVol: rightVol
	"Play my sound with reverberation."

	sound mixSampleCount: n
		into: aSoundBuffer
		startingAt: startIndex
		leftVol: leftVol
		rightVol: rightVol.
	self applyReverbTo: aSoundBuffer startingAt: startIndex count: n.
