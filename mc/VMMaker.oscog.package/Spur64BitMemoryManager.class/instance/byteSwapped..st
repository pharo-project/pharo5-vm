snapshot
byteSwapped: w
	"Answer the given integer with its bytes in the reverse order."
	<api>
	<returnTypeC: #sqInt>
	^  ((w bitShift: Byte7ShiftNegated) bitAnd: Byte0Mask)
	 + ((w bitShift: Byte5ShiftNegated) bitAnd: Byte1Mask)
	 + ((w bitShift: Byte3ShiftNegated) bitAnd: Byte2Mask)
	 + ((w bitShift: Byte1ShiftNegated) bitAnd: Byte3Mask)
	 + ((w bitShift: Byte1Shift             ) bitAnd: Byte4Mask)
	 + ((w bitShift: Byte3Shift             ) bitAnd: Byte5Mask)
	 + ((w bitShift: Byte5Shift             ) bitAnd: Byte6Mask)
	 + ((w bitShift: Byte7Shift             ) bitAnd: Byte7Mask)