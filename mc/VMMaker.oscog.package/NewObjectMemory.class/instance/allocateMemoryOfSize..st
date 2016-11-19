simulation
allocateMemoryOfSize: limit
	<doNotGenerate>
	super allocateMemoryOfSize: limit.
	freeStart := memoryLimit