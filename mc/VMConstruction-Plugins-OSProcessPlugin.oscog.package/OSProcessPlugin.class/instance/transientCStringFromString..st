private
transientCStringFromString: aString
	"Answer a new null-terminated C string copied from aString.
	The string is allocated in object memory, and will be moved
	without warning by the garbage collector. Any C pointer
	reference the the result is valid only until the garbage
	collector next runs. Therefore, this method should only be used
	within a single primitive in a section of code in which the
	garbage collector is guaranteed not to run. Note also that
	this method may itself invoke the garbage collector prior
	to allocating the new C string.

	Warning: The result of this method will be invalidated by the
	next garbage collection, including a GC triggered by creation
	of a new object within a primitive. Do not call this method
	twice to obtain two string pointers."

	| len stringPtr newString cString |
	<returnTypeC: 'char *'>
	<var: 'stringPtr' declareC: 'char *stringPtr'>
	<var: 'cString' declareC: 'char *cString'>
	len := interpreterProxy sizeOfSTArrayFromCPrimitive: (interpreterProxy arrayValueOf: aString).
	"Allocate space for a null terminated C string."
	interpreterProxy pushRemappableOop: aString.
	newString := interpreterProxy
		instantiateClass: interpreterProxy classString
		indexableSize: len + 1.
	stringPtr := interpreterProxy arrayValueOf: interpreterProxy popRemappableOop.
	cString := interpreterProxy arrayValueOf: newString.		"Point to the actual C string."
	self cCode: '(char *)strncpy(cString, stringPtr, len)'.		"Make a copy of the string."
	cString at: (len) put: 0.									"Null terminate the C string."
	^ cString
