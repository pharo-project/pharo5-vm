private
cStringFromString: aString
	"Answer a new null-terminated C string copied from aString. The C string
	is allocated from the C runtime heap. See transientCStringFromString for
	a version which allocates from object memory.
	Caution: This may invoke the garbage collector."

	| len sPtr cString |
	<returnTypeC: 'char *'>
	<var: 'sPtr' declareC: 'char *sPtr'>
	<var: 'cString' declareC: 'char *cString'>
	sPtr := interpreterProxy arrayValueOf: aString.
	len := interpreterProxy sizeOfSTArrayFromCPrimitive: sPtr.
	cString := self callocWrapper: len + 1 size: 1.			"Space for a null terminated C string."
	self cCode: '(char *) strncpy (cString, sPtr, len)'.	"Copy the string."
	^ cString
