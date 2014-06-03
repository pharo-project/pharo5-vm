snapshot
byteSwapped: w
	"Answer the given integer with its bytes in the reverse order."
	<api>
	<returnTypeC: #sqInt>
	^  ((w bitShift: Byte3ShiftNegated) bitAnd: Byte0Mask)
	 + ((w bitShift: Byte1ShiftNegated) bitAnd: Byte1Mask)
	 + ((w bitShift: Byte1Shift             ) bitAnd: Byte2Mask)
	 + ((w bitShift: Byte3Shift             ) bitAnd: Byte3Mask)