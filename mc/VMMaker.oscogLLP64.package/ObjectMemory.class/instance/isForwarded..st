interpreter access
isForwarded: oop
	"Compatibility wth SpurMemoryManager.  In ObjectMemory, no forwarding pointers
	 are visible to the VM."
	<api>
	<cmacro: '(oop) false'>
	<inline: true>
	^false