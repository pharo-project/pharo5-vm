asOop:/asValue:
generateCoerceToUnsignedValueFrom: aNode on: aStream
	self genCallOf: #positive32BitValueOf: with: aNode on: aStream