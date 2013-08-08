examples
majorScaleOn: aSound from: aPitch
	"FMSound majorScale play"

	^ self noteSequenceOn: aSound
		from: ((self majorPitchesFrom: aPitch)
			 collect: [:pitch | Array with: pitch with: 0.5 with: 300])
