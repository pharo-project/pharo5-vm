object access
rawOverflowSlotsOf: objOop
	<returnTypeC: #usqLong>
	<inline: true>
	self flag: #endianness.
	^self
		cCode: [((self longAt: objOop - self baseHeaderSize) << 8) asUnsignedLong >> 8]
		inSmalltalk: [(self longAt: objOop - self baseHeaderSize) bitAnd: 16rFFFFFFFFFFFFFF]