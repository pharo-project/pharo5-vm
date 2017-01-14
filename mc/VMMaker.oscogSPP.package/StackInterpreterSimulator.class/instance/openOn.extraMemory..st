initialization
openOn: fileName extraMemory: extraBytes
	"StackInterpreterSimulator new openOn: 'clone.im' extraMemory: 100000"

	| f version headerSize dataSize count oldBaseAddr bytesToShift swapBytes
	  headerFlags heapBase firstSegSize heapSize
	  hdrNumStackPages hdrEdenBytes hdrMaxExtSemTabSize allocationReserve |
	"open image file and read the header"

	f := FileStream readOnlyFileNamed: fileName.
	f ifNil: [^self error: 'no image found'].

	"Set the image name and the first argument; there are
	 no arguments during simulation unless set explicitly."
	systemAttributes at: 1 put: fileName; at: 2 put: nil.

	["begin ensure block..."
	imageName := f fullName.
	f binary.

	version := self getWord32FromFile: f swap: false.  "current version: 16r1968 (=6504) vive la revolucion!"
	(self readableFormat: version)
		ifTrue: [swapBytes := false]
		ifFalse: [(version := objectMemory byteSwapped: version) = self imageFormatVersion
					ifTrue: [swapBytes := true]
					ifFalse: [self error: 'incomaptible image format']].
	headerSize := self getWord32FromFile: f swap: swapBytes.
	dataSize := self getLongFromFile: f swap: swapBytes.  "length of heap in file"
	oldBaseAddr := self getLongFromFile: f swap: swapBytes.  "object memory base address of image"
	objectMemory specialObjectsOop: (self getLongFromFile: f swap: swapBytes).
	objectMemory lastHash: (self getLongFromFile: f swap: swapBytes).  "Should be loaded from, and saved to the image header"

	savedWindowSize	:= self getLongFromFile: f swap: swapBytes.
	headerFlags		:= self getLongFromFile: f swap: swapBytes.
	self setImageHeaderFlagsFrom: headerFlags.
	extraVMMemory	:= self getWord32FromFile: f swap: swapBytes.
	hdrNumStackPages	:= self getShortFromFile: f swap: swapBytes.
	"4 stack pages is small.  Should be able to run with as few as
	 three. 4 should be comfortable but slow.  8 is a reasonable
	 default. Can be changed via vmParameterAt: 43 put: n"
	numStackPages := desiredNumStackPages ~= 0
						ifTrue: [desiredNumStackPages]
						ifFalse: [hdrNumStackPages = 0
									ifTrue: [self defaultNumStackPages]
									ifFalse: [hdrNumStackPages]].
	desiredNumStackPages := hdrNumStackPages.
	"pad to word boundary.  This slot can be used for anything else that will fit in 16 bits.
	 It is used for the cog code size in Cog.  Preserve it to be polite to other VMs."
	theUnknownShort	:= self getShortFromFile: f swap: swapBytes.
	self assert: f position = (objectMemory wordSize = 4 ifTrue: [40] ifFalse: [64]).
	hdrEdenBytes		:= self getWord32FromFile: f swap: swapBytes.
	objectMemory edenBytes: (hdrEdenBytes = 0
							ifTrue: [objectMemory defaultEdenBytes]
							ifFalse: [hdrEdenBytes]).
	desiredEdenBytes := hdrEdenBytes.
	hdrMaxExtSemTabSize := self getShortFromFile: f swap: swapBytes.
	hdrMaxExtSemTabSize ~= 0 ifTrue:
		[self setMaxExtSemSizeTo: hdrMaxExtSemTabSize].
	"pad to word boundary.  This slot can be used for anything else that will fit in 16 bits.
	 Preserve it to be polite to other VMs."
	the2ndUnknownShort	:= self getShortFromFile: f swap: swapBytes.
	self assert: f position = (objectMemory wordSize = 4 ifTrue: [48] ifFalse: [72]).
	firstSegSize := self getLongFromFile: f swap: swapBytes.
	objectMemory firstSegmentSize: firstSegSize.
	"compare memory requirements with availability"
	allocationReserve := self interpreterAllocationReserveBytes.
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[| freeOldSpaceInImage headroom |
			 freeOldSpaceInImage := self getLongFromFile: f swap: swapBytes.
			 headroom := objectMemory
							initialHeadroom: extraVMMemory
							givenFreeOldSpaceInImage: freeOldSpaceInImage.
			 heapSize := objectMemory roundUpHeapSize:
						   dataSize
						+ headroom
						+ objectMemory newSpaceBytes
						+ (headroom > allocationReserve
							ifTrue: [0]
							ifFalse: [allocationReserve])]
		ifFalse:
			[heapSize :=  dataSize
						+ extraBytes
						+ objectMemory newSpaceBytes
						+ (extraBytes > allocationReserve
							ifTrue: [0]
							ifFalse: [allocationReserve])].
	"allocate interpreter memory"
	heapBase := objectMemory startOfMemory.
	objectMemory
		setHeapBase: heapBase
		memoryLimit: heapBase + heapSize
		endOfMemory: heapBase + dataSize. "bogus for Spur"
	objectMemory allocateMemoryOfSize: objectMemory memoryLimit.
	"read in the image in bulk, then swap the bytes if necessary"
	f position: headerSize.
	count := objectMemory readHeapFromImageFile: f dataBytes: dataSize.
	count ~= dataSize ifTrue: [self halt]]
		ensure: [f close].

	self ensureImageFormatIsUpToDate: swapBytes.

	bytesToShift := objectMemory memoryBaseForImageRead - oldBaseAddr.  "adjust pointers for zero base address"
	Utilities
		informUser: 'Relocating object pointers...'
		during: [self initializeInterpreter: bytesToShift]