util
unsafeDigitOfLargeInt: anOop at: ix
	"Argument must not be aSmallInteger!"
	<inline: true>
	<returnTypeC: #'unsigned int'>
	^self cDigitOf: (self pointerToFirstDigitOfLargeInt: anOop) at: ix - 1