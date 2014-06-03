object format
instSpecOfClass: classPointer
	"This is the same as the field stored in every object header"

	^self formatOfHeader: (self formatOfClass: classPointer)