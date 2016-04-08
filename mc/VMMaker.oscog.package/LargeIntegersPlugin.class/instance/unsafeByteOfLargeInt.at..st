util
unsafeByteOfLargeInt: bytesObj at: ix
	"Argument bytesObj must not be aSmallInteger!"
	<inline: true>
	<returnTypeC: #'unsigned char'>
	^(self firstIndexableField: bytesObj as: #'unsigned char *') at: ix - 1