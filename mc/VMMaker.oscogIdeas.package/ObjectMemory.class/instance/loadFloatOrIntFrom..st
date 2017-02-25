interpreter access
loadFloatOrIntFrom: floatOrInt
	"If floatOrInt is an integer, then convert it to a C double float and return it.
	 If it is a Float, then load its value and return it.
	 Otherwise fail -- ie return with primErrorCode non-zero."

	<inline: true>
	<returnTypeC: #double>

	(self isIntegerObject: floatOrInt) ifTrue:
		[^(self integerValueOf: floatOrInt) asFloat].
	^self floatValueOf: floatOrInt