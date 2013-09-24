simulation
allocateMemoryOfSize: memoryBytes newSpaceSize: newSpaceBytes codeSize: codeBytes
	"Intialize the receiver for bootsraping an image.
	 Set up a large oldSpace and an empty newSpace and set-up freeStart and scavengeThreshold
	 to allocate in oldSpace.  Later on (in initializePostBootstrap) freeStart and scavengeThreshold
	 will be set to sane values."
	<doNotGenerate>
	self assert: (memoryBytes \\ self allocationUnit = 0
				and: [newSpaceBytes \\ self allocationUnit = 0
				and: [codeBytes \\ self allocationUnit = 0]]).
	memory := (self endianness == #little
					ifTrue: [LittleEndianBitmap]
					ifFalse: [Bitmap]) new: (memoryBytes + newSpaceBytes + codeBytes) // 4.
	startOfMemory := codeBytes.
	endOfMemory := freeOldSpaceStart := memoryBytes + newSpaceBytes + codeBytes.
	"leave newSpace empty for the bootstrap"
	freeStart := newSpaceBytes + startOfMemory.
	newSpaceLimit := newSpaceBytes + startOfMemory.
	scavengeThreshold := memory size * 4. "Bitmap is a 4-byte per word array"
	scavenger := SpurGenerationScavengerSimulator new
					manager: self
					newSpaceStart: startOfMemory
					newSpaceBytes: newSpaceBytes
					edenBytes: newSpaceBytes * 5 // 7 "David's paper uses 140Kb eden + 2 x 28kb survivor spaces :-)"