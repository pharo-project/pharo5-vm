header access
isMarked: objOop
	<api>
	self flag: #endianness.
	^((self longAt: objOop + 4) >> self markedBitHalfShift bitAnd: 1) ~= 0