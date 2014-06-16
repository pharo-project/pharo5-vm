utility
versionNumberByteArrays
	"All byte array expressions of known version numbers. These are the possible values
	that may appear in the first 4 or 8 bytes of a saved image file. A 64 bit image saves
	its image format number as a 64 bit value in the file header, and a 32 bit image saves
	its image format as a 32 bit value. The value may be stored in little endian or big endian
	byte ordering depending on the host platform."

	"ImageFormat versionNumberByteArrays do: [:e |
		Transcript cr; show: e printString , ': ', (ImageFormat fromBytes: e) description]"

	^self allVersionNumberByteArrays select: [:e |
		e size = (self fromBytes: e) wordSize]
