accessing
extractParameters

	| pName value index globals |
	globals := Dictionary new.
	index := 2.
	[pName := Smalltalk getSystemAttribute: index.
	pName isEmptyOrNil] whileFalse:[
		index := index + 1.
		value := Smalltalk getSystemAttribute: index.
		value ifNil: [value := ''].
 		globals at: pName asLowercase put: value.
		index := index + 1].
	^globals