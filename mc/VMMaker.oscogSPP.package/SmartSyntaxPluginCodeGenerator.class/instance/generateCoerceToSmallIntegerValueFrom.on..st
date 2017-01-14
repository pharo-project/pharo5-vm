asOop:/asValue:
generateCoerceToSmallIntegerValueFrom: aNode on: aStream
	self genCallOf: #integerValueOf: with: aNode on: aStream