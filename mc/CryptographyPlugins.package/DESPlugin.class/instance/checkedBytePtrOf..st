support
checkedBytePtrOf: oop
	"Return the first indexable word of oop which is assumed to be
variableByteSubclass"
	self returnTypeC:'unsigned char *'.
	interpreterProxy success: (interpreterProxy isBytes: oop).
	^self cCoerce: (interpreterProxy firstIndexableField: oop) to:
'unsigned char *'
