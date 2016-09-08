utilities
fetchIntegerOrTruncFloat: fieldIndex ofObject: objectPointer
	"Return the integer value of the given field of the given object. If the field contains a Float, truncate it and return its integral part. Fail if the given field does not contain a small integer or Float, or if the truncated Float is out of the range of small integers."
	"Note: May be called by translated primitive code."

	| intOrFloat floatVal frac trunc |
	<inline: false>
	<var: #floatVal type: 'double '>
	<var: #frac type: 'double '>
	<var: #trunc type: 'double '>

	intOrFloat := self fetchPointer: fieldIndex ofObject: objectPointer.
	(self isIntegerObject: intOrFloat) ifTrue: [^ self integerValueOf: intOrFloat].
	self assertClassOf: intOrFloat is: (self splObj: ClassFloat).
	successFlag ifTrue: [
		self cCode: '' inSmalltalk: [floatVal := Float new: 2].
		self fetchFloatAt: intOrFloat + self baseHeaderSize into: floatVal.
		self cCode: 'frac = modf(floatVal, &trunc)'.
		"the following range check is for C ints, with range -2^31..2^31-1"
		self flag: #Dan.		"The ranges are INCORRECT if SmallIntegers are wider than 31 bits."
		self cCode: 'success((-2147483648.0 <= trunc) && (trunc <= 2147483647.0))'.].
	successFlag
		ifTrue: [^ self cCode: '((sqInt) trunc)' inSmalltalk: [floatVal truncated]]
		ifFalse: [^ 0].
