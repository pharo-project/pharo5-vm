Spur32BitCoMemoryManager is a refinement of Spur32BitMemoryManager that supports the CoInterpreter/Cogit just-in-time compiler.  The significant difference from Spur32BitMemoryManager is the memory layout.  Spur32BitCoMemoryManager adds the cogCodeZone beneath newSpace:

low address:
	cogCodeZone:
		generated run-time
		cog methods
		free space
		young referrers
	newSpace:
		past/future survivor space
		future/past survivor space
		eden
	first oldSpace segment
	...
	subsequent oldSpace segment
high address:

It would be convenient if the code zone were placed between newSpace and oldSpace; then Cog methods could be onsidered neither old nor young, filtering them out of copyAndForward: and the store check with single bounds checks.  But the CoInterpreter already assumes Cog methods are less than all objects (e.g. in its isMachineCodeFrame:).  If the dynamic frequency of isMachineCodeFrame: is higher (likely because this is used in e.g. scanning for unwind protects in non-local return) then it should keep the single bounds check.  So the coder zone remains beneath newSpace and Spur32BitCoMemoryManager ocerrides isReallyYoungObject: to filter-out Cog methods for copyAndForward:.

Instance Variables
	cogit:		<SimpleStackBasedCogit or subclass>

cogit
	- the just-in-time compiler