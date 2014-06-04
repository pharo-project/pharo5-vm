header access
isMarked: objOop
	<api>
	^((self longAt: objOop) >> self markedBitFullShift bitAnd: 1) ~= 0