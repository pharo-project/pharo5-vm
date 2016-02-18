object format
instSpecOfClass: classPointer
	"This field in a class's format inst var corresponds to the 4-bit format field stored in every object header"

	^self formatOfHeader: (self formatOfClass: classPointer)