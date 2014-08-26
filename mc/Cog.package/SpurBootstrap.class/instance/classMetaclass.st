bootstrap image
classMetaclass
	^classMetaclass ifNil:
		[classMetaclass := oldHeap fetchClassOfNonImm: (oldHeap fetchClassOfNonImm: oldHeap classArray)]