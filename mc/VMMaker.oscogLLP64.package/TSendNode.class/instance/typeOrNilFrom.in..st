type inference
typeOrNilFrom: aCodeGenerator in: aTMethod
	^aCodeGenerator returnTypeForSend: self in: aTMethod ifNil: nil