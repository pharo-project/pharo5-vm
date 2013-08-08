indexing primitive support
install: rcvr inAtCache: cache at: atIx string: stringy
	"Attempt to install the oop of this object in the given cache (at or atPut),
	 along with its size, format and fixedSize. Answer if this was successful."
	| hdr fmt totalLength fixedFields |
	<var: #cache type: 'sqInt *'>

	hdr := objectMemory baseHeader: rcvr.
	fmt := objectMemory formatOfHeader: hdr.
	(fmt = 3 and: [objectMemory isContextHeader: hdr]) ifTrue:
		["Contexts must not be put in the atCache, since their size is not constant"
		self primitiveFailFor: PrimErrBadReceiver.
		^false].
	totalLength := objectMemory lengthOf: rcvr baseHeader: hdr format: fmt.
	fixedFields := objectMemory fixedFieldsOf: rcvr format: fmt length: totalLength.

	cache at: atIx+AtCacheOop put: rcvr.
	cache at: atIx+AtCacheFmt put: (stringy
										ifTrue: [fmt + 16]  "special flag for strings"
										ifFalse: [fmt]).
	cache at: atIx+AtCacheFixedFields put: fixedFields.
	cache at: atIx+AtCacheSize put: totalLength - fixedFields.
	^true