SpurPigCompactor implements the second compactioon algorithm implemented for Spur.  It attempts to move ovbjects down from the end of memory to occupy free chunks in low memory.  It uses Knuth's xor-encoding technique to encode a doubly-linked list in the forwarding field of each free chunk (free chunks, like Spiur objects, being known to have at least one field).  This algorithm has poor performance for two reasons.  First, it does not preserve object order, scrambling the order of objects as it moves the highest objects down to the lowest free chunks.  Second it appears to perform badly, occasionally causing very long pauses.

Instance Variables
	coInterpreter:				<StackInterpreter>
	firstFreeChunk:				<Integer>
	lastFreeChunk:				<Integer>
	manager:					<SpurMemoryManager>
	numCompactionPasses:		<Integer>
	scavenger:					<SpurGenerationScavenger>

firstFreeChunk
	- oop of freeChunk or 0

lastFreeChunk
	- oop of freeChunk or 0

numCompactionPasses
	- 2 for normal GC, 3 for snapshot