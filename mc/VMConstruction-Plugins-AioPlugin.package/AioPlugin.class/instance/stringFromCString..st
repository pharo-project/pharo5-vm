private
stringFromCString: aCString
	"Answer a new String copied from a null-terminated C string.
	Caution: This may invoke the garbage collector."

	| len newString |
	<var: 'aCString' type: 'const char *'>
	len := self strlen: aCString.
	newString := interpreterProxy
		instantiateClass: interpreterProxy classString
		indexableSize: len.
	self st: (interpreterProxy arrayValueOf: newString)
		rn: aCString
		cpy: len. "(char *)strncpy()"
	^ newString

