object testing
isBytesNonImm: objOop
	"Answer true if the argument contains indexable bytes. See comment in formatOf:"
	^(self formatOf: objOop) >= self firstByteFormat