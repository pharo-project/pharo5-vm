header formats
instSpecForImmediateClasses
	"Use the format for forwarded objects for immediate classes.  Immediate classes (SmallInteger,
	 Character, etc) can't be instantiated, so the inst spec should be an invalid one to cause the
	 instantiation primitives to fail.  The forwardedFormat is internal to the SpurMemoryManager,
	 used to mark forwarded objects only, and so is suitable."
	^self forwardedFormat