initialization
defaultEdenBytes
	"Return the default amount of memory to allocate before doing a scavenge (incremental GC).
	 This default suits Qwaq Forums (specifically loading).  The actual value can be set via
	 vmParameterAt: and/or a preference in the ini file."
	<inline: false>
	^2 * 1024 * 1024