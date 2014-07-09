A SistaCogMethod is a CogMethod with a pointer to memory holding the Sista performance counters decremented in conditional branches.

Instance Variables
	counters:		<pointer>

counters
	- counters points to the first field of either a pinned object on the Spur heap or malloced memory.
