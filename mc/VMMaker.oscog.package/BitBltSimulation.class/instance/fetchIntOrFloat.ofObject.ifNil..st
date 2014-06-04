interpreter interface
fetchIntOrFloat: fieldIndex ofObject: objectPointer ifNil: defaultValue
	"Return the integer value of the given field of the given object. If the field contains a Float, truncate it and return its integral part. Fail if the given field does not contain a small integer or Float, or if the truncated Float is out of the range of small integers."
	| fieldOop floatValue |
	<var: #floatValue type:'double '>
	fieldOop := interpreterProxy fetchPointer: fieldIndex ofObject: objectPointer.
	(interpreterProxy isIntegerObject: fieldOop)
		ifTrue:[^interpreterProxy integerValueOf: fieldOop].
	(fieldOop = interpreterProxy nilObject) ifTrue:[^defaultValue].
	floatValue := interpreterProxy floatValueOf: fieldOop.
	(-2147483648.0 <= floatValue and:[floatValue <= 2147483647.0])
		ifFalse:[interpreterProxy primitiveFail. ^0].
	^floatValue asInteger