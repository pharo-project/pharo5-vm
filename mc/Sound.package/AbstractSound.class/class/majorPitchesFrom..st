examples
majorPitchesFrom: aPitch
	| chromatic |
	chromatic := self chromaticPitchesFrom: aPitch.
	^ #(1 3 5 6 8 10 12 13 15 13 12 10 8 6 5 3 1) collect: [:i | chromatic at: i].
