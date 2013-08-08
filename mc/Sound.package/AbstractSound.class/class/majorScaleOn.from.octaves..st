examples
majorScaleOn: aSound from: aPitch octaves: octaveCount
	"(AbstractSound majorScaleOn: FMSound oboe1 from: #c2 octaves: 5) play"

	| startingPitch pitches chromatic |
	startingPitch := aPitch isNumber
		ifTrue: [aPitch]
		ifFalse: [self pitchForName: aPitch].
	pitches := OrderedCollection new.
	0 to: octaveCount - 1 do: [:i |
		chromatic := self chromaticPitchesFrom: startingPitch * (2 raisedTo: i).
		#(1 3 5 6 8 10 12) do: [:j | pitches addLast: (chromatic at: j)]].
	pitches addLast: startingPitch * (2 raisedTo: octaveCount).
	^ self noteSequenceOn: aSound
		from: (pitches collect: [:pitch | Array with: pitch with: 0.5 with: 300])
