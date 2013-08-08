private
applyReverbTo: aSoundBuffer startingAt: startIndex count: n

	| delayedLeft delayedRight i tapGain j out |
	<primitive: 'primitiveApplyReverb' module:'SoundGenerationPlugin'>
	
	<var: #aSoundBuffer declareC: 'short int *aSoundBuffer'>
	<var: #tapDelays declareC: 'int *tapDelays'>
	<var: #tapGains declareC: 'int *tapGains'>
	<var: #leftBuffer declareC: 'short int *leftBuffer'>
	<var: #rightBuffer declareC: 'short int *rightBuffer'>

	startIndex to: ((startIndex + n) - 1) do: [:sliceIndex |
		delayedLeft := delayedRight := 0.
		1 to: tapCount do: [:tapIndex |
			i := bufferIndex - (tapDelays at: tapIndex).
			i < 1 ifTrue: [i := i + bufferSize].  "wrap"
			tapGain := tapGains at: tapIndex.
			delayedLeft := delayedLeft + (tapGain * (leftBuffer at: i)).
			delayedRight := delayedRight + (tapGain * (rightBuffer at: i))].

		"left channel"
		j := (2 * sliceIndex) - 1.
		out := (aSoundBuffer at: j) + (delayedLeft // ScaleFactor).
		out >  32767 ifTrue: [out :=  32767].  "clipping!"
		out < -32767 ifTrue: [out := -32767].  "clipping!"
		aSoundBuffer at: j put: out.
		leftBuffer at: bufferIndex put: out.

		"right channel"
		j := j + 1.
		out := (aSoundBuffer at: j) + (delayedRight // ScaleFactor).
		out >  32767 ifTrue: [out :=  32767].  "clipping!"
		out < -32767 ifTrue: [out := -32767].  "clipping!"
		aSoundBuffer at: j put: out.
		rightBuffer at: bufferIndex put: out.

		bufferIndex := (bufferIndex \\ bufferSize) + 1].
