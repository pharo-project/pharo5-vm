primitive support
stringForCString: aCString
	"Answer a new String copied from a null-terminated C string,
	 or nil if out of memory."
	<api>
	<var: 'aCString' type: 'const char *'>
	<inline: false>
	| len newString |
	len := self strlen: aCString.
	newString := self
					allocateSlots: (self numSlotsForBytes: len)
					format: (self byteFormatForNumBytes: len)
					classIndex: ClassByteStringCompactIndex.
	newString ifNotNil:
		[self st: (self cCoerceSimple: newString + self baseHeaderSize to: #'char *')
			rn: aCString
			cpy: len]. "(char *)strncpy()"
	^newString