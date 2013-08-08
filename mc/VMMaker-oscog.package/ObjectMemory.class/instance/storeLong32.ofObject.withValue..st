interpreter access
storeLong32: fieldIndex ofObject: oop withValue: valueWord

	^ self long32At: oop + BaseHeaderSize + (fieldIndex << 2)
		put: valueWord