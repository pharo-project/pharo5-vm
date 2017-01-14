combination rules
bitOrInvert: sourceWord with: destinationWord
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	^sourceWord bitOr: destinationWord bitInvert32