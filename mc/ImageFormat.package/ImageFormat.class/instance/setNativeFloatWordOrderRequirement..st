initialize-release
setNativeFloatWordOrderRequirement: aBoolean
	"If true, certain objects are implemented in native platform word order. On
	a little endian platform, access to the two words of a 64 bit float object is
	more efficient if the words are stored in native word order. On a big endian
	platform, platform word order is the same as object memory word order and
	this setting has no effect.
	
	The StackInterpreter and Cog make use of this for performance reasons."

	requiresNativeFloatWordOrder := aBoolean
