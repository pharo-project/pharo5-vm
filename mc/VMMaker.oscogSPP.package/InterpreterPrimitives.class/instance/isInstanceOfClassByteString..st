primitive support
isInstanceOfClassByteString: oop
	<inline: true>
	"N.B.  Because Slang always inlines is:instanceOf:compactClassIndex:
	 (because is:instanceOf:compactClassIndex: has an inline: pragma) the
	 phrase (objectMemory splObj: ClassByteString) is expanded in-place and
	 is _not_ evaluated if oop has a non-zero CompactClassIndex."
	^objectMemory
		is: oop
		instanceOf: (objectMemory splObj: ClassByteString) 
		compactClassIndex: ClassByteStringCompactIndex