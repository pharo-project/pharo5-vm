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
	memory := (self endianness == #little
					ifTrue: [LittleEndianBitmap]
					ifFalse: [Bitmap]) new: (memoryBytes + newSpaceBytes + codeBytes + stackBytes) // 4.
	newSpaceStart := codeBytes + stackBytes.
	endOfMemory := freeOldSpaceStart := memoryBytes + newSpaceBytes + codeBytes + stackBytes.
	"leave newSpace empty for the bootstrap"
	freeStart := newSpaceBytes + newSpaceStart.
	oldSpaceStart := newSpaceLimit := newSpaceBytes + newSpaceStart.
	scavengeThreshold := memory size * 4. "Bitmap is a 4-byte per word array"
	scavenger := SpurGenerationScavengerSimulator new.
	scavenger manager: self.
	scavenger newSpaceStart: newSpaceStart
				newSpaceBytes: newSpaceBytes
				survivorBytes: newSpaceBytes // self scavengerDenominator