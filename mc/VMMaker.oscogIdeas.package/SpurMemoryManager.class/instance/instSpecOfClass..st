object format
instSpecOfClass: classPointer
	"This field in a class's format inst var corresponds to the 5-bit format field stored in every object header"

	^self instSpecOfClassFormat: (self formatOfClass: classPointer)