indexing primitive support
stSizeOf: oop
	"Return the number of indexable fields in the given object. (i.e., what Smalltalk would return for <obj> size)."
	"Note: Assume oop is not a SmallInteger!"

	| hdr fmt totalLength fixedFields |
	<inline: false>
	hdr := objectMemory baseHeader: oop.
	fmt := objectMemory formatOfHeader: hdr.
	totalLength := objectMemory lengthOf: oop baseHeader: hdr format: fmt.
	fixedFields := objectMemory fixedFieldsOf: oop format: fmt length: totalLength.
	fmt = objectMemory indexablePointersFormat ifTrue:
		[self assert: (objectMemory isContextHeader: hdr) not].
	^totalLength - fixedFields