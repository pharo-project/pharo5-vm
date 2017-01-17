primitives
primitiveFFIGetLastError
	"Primitive. Return the error code from a failed call to the foreign function interface.
	 This is for backwards-compatibility.  Thread-safe access to the error code is via the
	 primitive error code."
	<export: true>
	<inline: false>
	interpreterProxy pop: 1.
	^interpreterProxy pushInteger: ffiLastError