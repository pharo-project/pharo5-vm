object access
fetchLong64: longIndex ofObject: oop
	<returnTypeC: #sqLong>
	^self long64At: oop + BaseHeaderSize + (longIndex << 3)