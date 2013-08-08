combination rules
bitInvertOrInvert: sourceWord with: destinationWord
	^sourceWord bitInvert32 bitOr: destinationWord bitInvert32