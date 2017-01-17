object access
fetchLong64: longIndex ofObject: objOop
	<returnTypeC: #sqLong>
	^self long64At: objOop + self baseHeaderSize + (longIndex << 3)