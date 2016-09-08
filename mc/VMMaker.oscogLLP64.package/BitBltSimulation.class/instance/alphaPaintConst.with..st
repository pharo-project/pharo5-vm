combination rules
alphaPaintConst: sourceWord with: destinationWord
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>

	sourceWord = 0 ifTrue: [^ destinationWord  "opt for all-transparent source"].
	^ self alphaBlendConst: sourceWord with: destinationWord paintMode: true