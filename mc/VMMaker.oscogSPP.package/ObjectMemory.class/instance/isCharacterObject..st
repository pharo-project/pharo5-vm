interpreter access
isCharacterObject: oop
	<inline: true>
	"N.B.  Because Slang always inlines is:instanceOf:compactClassIndex:
	 (because is:instanceOf:compactClassIndex: has an inline: pragma) the
	 phrase (self splObj: ClassCharacter) is expanded in-place
	 and is _not_ evaluated if oop has a non-zero CompactClassIndex."
	^self
		is: oop
		instanceOf: (self splObj: ClassCharacter) 
		compactClassIndex: 0