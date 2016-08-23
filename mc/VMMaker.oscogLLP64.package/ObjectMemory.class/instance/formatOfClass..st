object format
formatOfClass: classPointer
	"**should be in-lined**"
	"Note that, in Smalltalk, the instSpec will be equal to the inst spec
	part of the base header of an instance (without hdr type) shifted left 1.
	In this way, apart from the smallInt bit, the bits
	are just where you want them for the first header word."
	"Callers (must) expect low 2 bits (header type) to be zero!"
	<api>
	<inline: true>
	^(self fetchPointer: InstanceSpecificationIndex ofObject: classPointer) - 1