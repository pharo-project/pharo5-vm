public access
munge: imageName
	interpreter := StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur32BitMemoryManager).
	interpreter desiredNumStackPages: 4; initStackPages.
	heap := interpreter objectMemory.
	self assert: heap class == Spur32BitMMLESimulator.
	SpurOldFormat32BitMMLESimulator adoptInstance: heap.
	interpreter openOn: imageName extraMemory: 0.
	self mapPCs.
	self preparePrototypes.
	self updateAndForwardMethods.
	self snapshot