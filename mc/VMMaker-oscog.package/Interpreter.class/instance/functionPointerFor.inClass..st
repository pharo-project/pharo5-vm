method lookup cache
functionPointerFor: primIdx inClass: theClass
	"Find an actual function pointer for this primitiveIndex.  This is an
	opportunity to specialise the prim for the relevant class (format for
	example).  Default for now is simply the entry in the base primitiveTable."

	<returnTypeC: 'void *'>
	^primitiveTable at: primIdx