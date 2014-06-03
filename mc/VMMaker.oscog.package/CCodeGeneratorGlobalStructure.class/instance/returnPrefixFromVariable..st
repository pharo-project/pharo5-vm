C code generator
returnPrefixFromVariable: aName
	^((variables includes: aName)
	   and: [self placeInStructure: aName])
		ifTrue: ['GIV(',aName,')']
		ifFalse: [aName]