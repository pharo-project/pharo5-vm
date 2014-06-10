combination rules
bitInvertAndInvert: sourceWord with: destinationWord
	^sourceWord bitInvert32 bitAnd: destinationWord bitInvert32