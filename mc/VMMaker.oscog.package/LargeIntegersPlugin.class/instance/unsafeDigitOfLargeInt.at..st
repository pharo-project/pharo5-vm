util
unsafeDigitOfLargeInt: anOop at: ix
	"Argument must not be aSmallInteger!"
	<inline: true>
	<returnTypeC: #'unsigned int'>
	^self cDigitOf: (interpreterProxy cCoerce: (interpreterProxy firstIndexableField: anOop) to: #'unsigned int *') at: ix - 1