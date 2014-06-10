util
unsafeByteOf: bytesOop at: ix
	"Argument bytesOop must not be aSmallInteger!"
	<inline: true>
	| pointer |
	<var: #pointer type: #'unsigned char *'>
	^(pointer := interpreterProxy firstIndexableField: bytesOop) at: ix - 1