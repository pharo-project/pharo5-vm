util
unsafeByteOfLargeInt: bytesObj at: ix
	"Argument bytesObj must not be aSmallInteger!"
	<inline: true>
	<returnTypeC: #'unsigned char'>
	^(interpreterProxy cCoerce: (interpreterProxy firstIndexableField: bytesObj) to: #'unsigned char *') at: ix - 1