other primitives
primitiveImageFormatVersion
	"Answer an integer identifying the type of image. The image version number may
	identify the format of the image (e.g. 32 or 64-bit word size) or specific requirements
	of the image (e.g. block closure support required).
	
	This is a named (not numbered) primitive in the null module (ie the VM)"

	<export: true>
	self pop: 1 thenPush: (self positive32BitIntegerFor: self imageFormatVersion)
