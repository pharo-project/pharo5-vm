private
ftStringFromEncodingValue: encoding
	"Return a newly allocated String from the given 32-bit word"

	| ptr stringOop |
	self var: #encoding type: 'FT_Encoding'.
	self var: #ptr type: 'unsigned char*'.

	stringOop := interpreterProxy
				instantiateClass: interpreterProxy classString
				indexableSize: (self cCode: 'sizeof(FT_Encoding)').
	self touch: stringOop.
	interpreterProxy failed ifTrue: [ ^nil ].

	ptr := interpreterProxy firstIndexableField: stringOop.
	self touch: ptr.

	self cCode: 'ptr[0] = (encoding & 0xFF000000) >> 24'.
	self cCode: 'ptr[1] = (encoding & 0x00FF0000) >> 16'.
	self cCode: 'ptr[2] = (encoding & 0x0000FF00) >> 8'.
	self cCode: 'ptr[3] = (encoding & 0x000000FF)'.

	^stringOop
