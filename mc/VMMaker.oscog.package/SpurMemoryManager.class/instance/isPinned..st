header access
isPinned: objOop
	<api>
	^((self longAt: objOop) >> self pinnedBitShift bitAnd: 1) ~= 0