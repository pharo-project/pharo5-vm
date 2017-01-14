combination rules
bitInvertAndInvert: sourceWord with: destinationWord
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	^sourceWord bitInvert32 bitAnd: destinationWord bitInvert32