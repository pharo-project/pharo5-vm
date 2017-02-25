indexing primitive support
install: rcvr inAtCache: cache at: atIx string: stringy
	"Attempt to install the oop of this object in the given cache (at or atPut),
	 along with its size, format and fixedSize. Answer if this was successful."
	| hdr fmt totalLength fixedFields |
	<inline: true>
	<var: #cache type: 'sqInt *'>
	self assert: (objectMemory isContext: rcvr) not.
	hdr := objectMemory baseHeader: rcvr.
	fmt := objectMemory formatOfHeader: hdr.
	"For now the AtCache code doesn't support 16-bit indexability."
	(objectMemory hasSpurMemoryManagerAPI
	and: [fmt between: objectMemory firstShortFormat and: objectMemory firstByteFormat - 1]) ifTrue:
		[^self primitiveFail].
	stringy
		ifTrue:
			[totalLength := objectMemory lengthOf: rcvr baseHeader: hdr format: fmt.
			 fixedFields := 0.
			 fmt := fmt + objectMemory firstStringyFakeFormat]  "special flag for strings"
		ifFalse:
			[(fmt = objectMemory indexablePointersFormat and: [objectMemory isContextHeader: hdr]) ifTrue:
				["Contexts must not be put in the atCache, since their size is not constant"
				self primitiveFailFor: PrimErrBadReceiver.
				^false].
			 totalLength := objectMemory lengthOf: rcvr baseHeader: hdr format: fmt.
			 fixedFields := objectMemory fixedFieldsOf: rcvr format: fmt length: totalLength].

	cache at: atIx+AtCacheOop put: rcvr.
	cache at: atIx+AtCacheFmt put: fmt.
	cache at: atIx+AtCacheFixedFields put: fixedFields.
	cache at: atIx+AtCacheSize put: totalLength - fixedFields.
	^true