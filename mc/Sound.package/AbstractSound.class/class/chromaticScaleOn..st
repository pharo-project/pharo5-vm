examples
chromaticScaleOn: aSound
	"PluckedSound chromaticScale play"

	^ self noteSequenceOn: aSound
		from: (((self chromaticPitchesFrom: #c4) copyFrom: 1 to: 13)
			 collect: [:pitch | Array with: pitch with: 0.5 with: 300])
