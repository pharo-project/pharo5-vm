primitives
netAddressToInt: ptrToByteArray
	"Convert the given internet network address (represented as a four-byte ByteArray) into a 32-bit integer. Fail if the given ptrToByteArray does not appear to point to a four-byte ByteArray."

	| sz |
	<var: #ptrToByteArray type: 'unsigned char * '>
	sz := interpreterProxy byteSizeOf: ptrToByteArray cPtrAsOop.
	sz = 4 ifFalse: [^ interpreterProxy primitiveFail].
	^ (ptrToByteArray at: 3	) +
		((ptrToByteArray at: 2) <<8) +
		((ptrToByteArray at: 1) <<16) +
		((ptrToByteArray at: 0) <<24)