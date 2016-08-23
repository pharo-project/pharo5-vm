accessing
getDefaultCogCodeSize
	"Answer the default number of bytes to allocate for native code at startup.
	 The actual value can be set via vmParameterAt: and/or a preference in the ini file.
	 Subclasses may this default override to arrange that the code zone has about
	 the same number of methods as the x86 back-end at a similar point in execution."
	<inline: true>
	^1024 * 1024