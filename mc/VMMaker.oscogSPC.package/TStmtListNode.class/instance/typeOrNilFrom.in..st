type inference
typeOrNilFrom: aCodeGenerator in: aTMethod
	^statements isEmpty ifFalse:
		[statements last typeOrNilFrom: aCodeGenerator in: aTMethod]