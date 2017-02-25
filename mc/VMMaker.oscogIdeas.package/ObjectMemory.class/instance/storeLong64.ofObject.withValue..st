object access
storeLong64: longIndex ofObject: oop withValue: value
	<var: #value type: #sqLong>
	self flag: #endianness.
	self long32At: oop + self baseHeaderSize + (longIndex << 3) put: (self cCode: [value] inSmalltalk: [value bitAnd: 16rFFFFFFFF]);
		long32At: oop + self baseHeaderSize + (longIndex << 3) + 4 put: (value >> 32).
	^value