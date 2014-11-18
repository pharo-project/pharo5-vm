object access
storeLong64: longIndex ofObject: oop withValue: value
	<var: #value type: #sqLong>
	^self long64At: oop + self baseHeaderSize + (longIndex << 3) put: value