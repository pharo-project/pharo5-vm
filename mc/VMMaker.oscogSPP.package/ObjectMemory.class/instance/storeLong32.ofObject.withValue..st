object access
storeLong32: fieldIndex ofObject: oop withValue: valueWord

	^ self long32At: oop + self baseHeaderSize + (fieldIndex << 2)
		put: valueWord