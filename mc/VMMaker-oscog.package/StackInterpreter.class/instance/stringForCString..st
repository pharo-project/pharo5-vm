primitive support
stringForCString: aCString
	"Answer a new String copied from a null-terminated C string,
	 or nil if out of memory.
	 Caution: This may invoke the garbage collector."
	<api>
	<var: 'aCString' type: 'const char *'>
	| len newString |
	len := self strlen: aCString.
	newString := objectMemory instantiateClass: objectMemory classString indexableSize: len.
	newString isNil ifFalse:
		[self st: (self arrayValueOf: newString)
			rn: aCString
			cpy: len]. "(char *)strncpy()"
	^newString