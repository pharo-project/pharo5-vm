primitives
primitiveFFIGetLastError
	"Primitive. Return the error code from a failed call to the foreign function interface."
	<export: true>
	<inline: false>
	interpreterProxy pop: 1.
	^interpreterProxy pushInteger: self ffiGetLastError.