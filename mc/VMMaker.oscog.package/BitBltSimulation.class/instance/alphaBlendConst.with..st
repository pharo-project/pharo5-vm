combination rules
alphaBlendConst: sourceWord with: destinationWord
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>

	^ self alphaBlendConst: sourceWord with: destinationWord paintMode: false