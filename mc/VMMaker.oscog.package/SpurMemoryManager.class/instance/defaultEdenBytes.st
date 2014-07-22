snapshot
defaultEdenBytes
	"Answer the default amount of memory to allocate for the eden space.
	 The actual value can be set via vmParameterAt: and/or a preference in the ini file.
	 The shootout tests seem to plateau at 5 or 6Mb"
	<inline: false>
	^4 * 1024 * 1024