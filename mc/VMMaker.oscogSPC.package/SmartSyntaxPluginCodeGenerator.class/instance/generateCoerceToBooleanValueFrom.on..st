asOop:/asValue:
generateCoerceToBooleanValueFrom: aNode on: aStream
	self genCallOf: #booleanValueOf: with: aNode receiver on: aStream