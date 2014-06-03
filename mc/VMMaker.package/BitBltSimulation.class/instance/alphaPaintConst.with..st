combination rules
alphaPaintConst: sourceWord with: destinationWord

	sourceWord = 0 ifTrue: [^ destinationWord  "opt for all-transparent source"].
	^ self alphaBlendConst: sourceWord with: destinationWord paintMode: true