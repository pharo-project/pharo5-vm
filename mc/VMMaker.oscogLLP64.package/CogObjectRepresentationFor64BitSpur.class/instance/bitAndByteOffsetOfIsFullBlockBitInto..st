in-line cacheing
bitAndByteOffsetOfIsFullBlockBitInto: aBlock
	<inline: true>
	"This supplies the bitmask for the isFullBlock bit, and the offset of the byte containing
	 that bit in a CogMethod header to aBlock.  We don't have named variables holding this
	 offset.  Th efollowing assert tsts whether the values are correct by creating a surrogate
	 on an empty ByteArray, setting the bit, and checking that the exopected values are set
	 in the ByteArray."
	self cCode: [] inSmalltalk:
		[| m |
		m := ByteArray new: 16.
		CogBlockMethodSurrogate64 new
			at: 0 memory: m headerSize: 8 cogit: nil;
			cpicHasMNUCaseOrCMIsFullBlock: true.
		self assert: m = #[0 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0].
		self assert: (m at: objectMemory baseHeaderSize + 2) = 16].
	aBlock value: 16 value: objectMemory baseHeaderSize + 2