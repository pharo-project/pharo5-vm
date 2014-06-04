object access
storeLong32: fieldIndex ofObject: obj withValue: valueWord
	^self long32At: obj + self baseHeaderSize + (fieldIndex << 2) put: valueWord