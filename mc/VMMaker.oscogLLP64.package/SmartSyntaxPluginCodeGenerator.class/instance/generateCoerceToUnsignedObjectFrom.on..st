asOop:/asValue:
generateCoerceToUnsignedObjectFrom: aNode on: aStream
	self genCallOf: #positive32BitIntegerFor: with: aNode on: aStream