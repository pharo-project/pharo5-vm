interpreter access
isOopForwarded: oop
	"Compatibility wth SpurMemoryManager.  In ObjectMemory, no forwarding pointers
	 are visible to the VM."
	<inline: true>
	^false