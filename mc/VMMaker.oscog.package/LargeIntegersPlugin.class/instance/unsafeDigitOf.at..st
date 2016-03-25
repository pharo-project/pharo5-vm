util
unsafeDigitOf: bytesObj at: ix
	"Argument bytesObj must not be aSmallInteger!"
	<inline: true>
	^(interpreterProxy cCoerce: (interpreterProxy firstIndexableField: bytesObj) to: #'unsigned char *') at: ix - 1