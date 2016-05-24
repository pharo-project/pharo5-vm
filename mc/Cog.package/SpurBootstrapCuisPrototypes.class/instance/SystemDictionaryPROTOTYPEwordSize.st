method prototypes
SystemDictionaryPROTOTYPEwordSize
	"Answer the size in bytes of an object pointer or word in the object memory.
	 The value does not change for a given image, but may be modified by a SystemTracer
	 when converting the image to another format."

	"Smalltalk wordSize"

	^self vmParameterAt: 40