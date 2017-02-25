type inference
typeOrNilFrom: aCodeGenerator in: aTMethod
	"This is the default type in case of doubt"
	^(variable typeOrNilFrom: aCodeGenerator in: aTMethod) ifNil:
		[expression typeOrNilFrom: aCodeGenerator in: aTMethod]