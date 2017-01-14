type inference
typeFrom: aCodeGenerator in: aTMethod
	"This is the default type in case of doubt"
	^(self typeOrNilFrom: aCodeGenerator in: aTMethod) ifNil: [#sqInt]