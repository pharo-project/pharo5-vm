util
unsafeDigitOfLargeInt: anOop at: ix
	"Argument must not be aSmallInteger!"
	<inline: true>
	<returnTypeC: #'unsigned int'>
	^self cDigitOf: (self firstIndexableField: anOop as: #'unsigned int *') at: ix - 1