object access
storeLong64: longIndex ofObject: objOop withValue: value
	<var: #value type: #sqLong>
	^self long64At: objOop + self baseHeaderSize + (longIndex << 3) put: value