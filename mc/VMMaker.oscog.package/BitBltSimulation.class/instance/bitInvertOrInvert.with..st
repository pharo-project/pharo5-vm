combination rules
bitInvertOrInvert: sourceWord with: destinationWord
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	^sourceWord bitInvert32 bitOr: destinationWord bitInvert32