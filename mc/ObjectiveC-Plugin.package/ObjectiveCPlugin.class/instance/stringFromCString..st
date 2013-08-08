system primitives
stringFromCString: aCString
	"Answer a new String copied from a null-terminated C string.
	Caution: This may invoke the garbage collector."

	| len newString |
	self var: 'aCString' type: 'const char *'.
	len := self cCoerce: (self strlen: aCString) to: 'sqInt'. 
	newString := interpreterProxy
		instantiateClass: interpreterProxy classString
		indexableSize: len.
	self st: (interpreterProxy arrayValueOf: newString)
		rn: aCString
		cpy: len. "(char *)strncpy()"
	^ newString

