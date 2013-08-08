private
ftEncodingValueFromString: string
	"Return a 32-bit word from the bytes held by string."
	| ptr retval |
	self returnTypeC: 'FT_Encoding'.
	self var: #ptr type: 'unsigned char*'.
	self var: #retval type: 'unsigned long'.
	interpreterProxy success:
		((interpreterProxy isIntegerObject: string) not and:
		 [(interpreterProxy isBytes: string) and:
		 [(interpreterProxy slotSizeOf: string) = (self cCode: 'sizeof(FT_Encoding)')]]).
	interpreterProxy failed ifTrue: [ ^nil ].

	retval := 0.
	ptr := interpreterProxy arrayValueOf: string.
	
	"	ptr := self cCode: '(unsigned char *) (string + 4)'."

	self touch: ptr.

	retval := self cCode: '((unsigned long)ptr[0]) << 24'.
	self cCode: 'retval += ((unsigned long)ptr[1]) << 16'.
	self cCode: 'retval += ((unsigned long)ptr[2]) << 8'.
	self cCode: 'retval += (unsigned long)ptr[3]'.
	self touch: retval.

	^self cCode: '(FT_Encoding)retval'.
