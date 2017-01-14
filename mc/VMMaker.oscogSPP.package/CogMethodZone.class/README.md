I am a simple allocator/deallocator for the native code zone.  I also manage the youngReferers list, which contains methods that may refer to one or more young objects, and the openPICList which is a linked list of all open PICs in the zone.

Instance Variables
	baseAddress:								<Integer address>
	coInterpreter:								<CoInterpreter>
	cogit:										<Cogit>
	limitAddress:								<Integer address>
	methodBytesFreedSinceLastCompaction:	<Integer>
	methodCount:								<Integer>
	mzFreeStart:								<Integer address>
	objectMemory:								<NewCoObjectMemory|SpurCoMemoryManager>
	objectRepresentation:						<CogObjectRepresentation:>
	openPICList:								<CogMethod *|nil>
	unpairedMethodList:						<CogMethod *|nil>
	youngReferrers:							<Integer address>

baseAddress
	- the lowest address in the native method zone

coInterpreter
	- simulation-only

cogit
	- simulation-only

limitAddress
	- the address immediately following the native method zone

methodBytesFreedSinceLastCompaction
	- a count of the bytes in methods freed since the last compaction of the native method zone, used to answer the used bytes in the zone

methodCount
	- a count of the number of methods in the native method zone

mzFreeStart
	- the start of free space in the zone

objectMemory
	- simulation-only

objectRepresentation
	- simulation-only

openPICList
	- the head of the list of open PICs

unpairedMethodList
	- the head of the list of Cog methods with no associated CompiledMethod object (Newspeak only)

youngReferrers
	- the pointer to the start of an array of pointers to CogMethods that refer to young objects.  May contain false positives.  Occupies the top of the zone from youngReferrers up to limitAddress
