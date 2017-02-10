spur bootstrap
allocateMemoryOfSize: memoryBytes newSpaceSize: newSpaceBytes stackSize: stackBytes codeSize: codeBytes
	"Intialize the receiver for bootsraping an image.
	 Set up a large oldSpace and an empty newSpace and set-up freeStart and scavengeThreshold
	 to allocate in oldSpace.  Later on (in initializePostBootstrap) freeStart and scavengeThreshold
	 will be set to sane values."
	<doNotGenerate>
	self assert: (memoryBytes \\ self allocationUnit = 0
				and: [newSpaceBytes \\ self allocationUnit = 0
				and: [codeBytes \\ self allocationUnit = 0]]).
	self allocateMemoryOfSize: memoryBytes + newSpaceBytes + codeBytes + stackBytes.
	newSpaceStart := codeBytes + stackBytes.
	endOfMemory := freeOldSpaceStart := memoryBytes + newSpaceBytes + codeBytes + stackBytes.
	"leave newSpace empty for the bootstrap"
	freeStart := newSpaceBytes + newSpaceStart.
	oldSpaceStart := newSpaceLimit := newSpaceBytes + newSpaceStart.
	scavengeThreshold := memory size * memory bytesPerElement. "i.e. /don't/ scavenge."
	scavenger := SpurGenerationScavenger simulatorClass new.
	scavenger manager: self.
	scavenger newSpaceStart: newSpaceStart
				newSpaceBytes: newSpaceBytes
				survivorBytes: newSpaceBytes // self scavengerDenominator.
	compactor := self class compactorClass simulatorClass new manager: self; yourself