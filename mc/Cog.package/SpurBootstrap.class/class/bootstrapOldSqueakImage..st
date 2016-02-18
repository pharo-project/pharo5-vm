utilities
bootstrapOldSqueakImage: imageFileBaseName
	"Try asnd bootstrap a pre-CompiledMethodTrailer Squeak image."
	self bootstrapImage: imageFileBaseName type: #('squeak' 'old squeak')