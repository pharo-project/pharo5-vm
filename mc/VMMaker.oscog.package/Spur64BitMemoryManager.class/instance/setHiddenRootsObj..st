class table
setHiddenRootsObj: anOop
	"Override to check for and abort old format 64-bit Spur images in which the smallFloatTag is 3."
	super setHiddenRootsObj: anOop.
	(self bootstrapping not
	 and: [self smallFloatTag ~= (self rawHashBitsOf: (self fetchPointer: self smallFloatTag
															ofObject: classTableFirstPage))]) ifTrue:
		[self error: 'This is an old-format 64-bit Spur image with smallFloatTag = 3.  Aborting.']