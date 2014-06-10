initialization
openOn: fileName extraMemory: extraBytes
	"CogVMSimulator new openOn: 'clone.im' extraMemory: 100000"

	| f version headerSize dataSize count oldBaseAddr bytesToShift swapBytes
	  headerFlags firstSegSize heapSize
	  hdrNumStackPages hdrEdenBytes hdrMaxExtSemTabSize
	  hdrCogCodeSize stackZoneSize methodCacheSize primTraceLogSize |
	"open image file and read the header"

	f := FileStream readOnlyFileNamed: fileName.
	f ifNil: [^self error: 'no image found'].

	["begin ensure block..."
	imageName := f fullName.
	f binary.

	version := self nextLongFrom: f.  "current version: 16r1968 (=6504) vive la revolucion!"
	(self readableFormat: version)
		ifTrue: [swapBytes := false]
		ifFalse: [(version := objectMemory byteSwapped: version) = self imageFormatVersion
					ifTrue: [swapBytes := true]
					ifFalse: [self error: 'incomaptible image format']].
	headerSize := self getLongFromFile: f swap: swapBytes.
	dataSize := self getLongFromFile: f swap: swapBytes.  "length of heap in file"
	oldBaseAddr := self getLongFromFile: f swap: swapBytes.  "object memory base address of image"
	objectMemory specialObjectsOop: (self getLongFromFile: f swap: swapBytes).
	objectMemory lastHash: (self getLongFromFile: f swap: swapBytes).  "Should be loaded from, and saved to the image header"

	savedWindowSize	:= self getLongFromFile: f swap: swapBytes.
	headerFlags		:= self getLongFromFile: f swap: swapBytes.
	self setImageHeaderFlagsFrom: headerFlags.
	extraVMMemory	:= self getLongFromFile: f swap: swapBytes.
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
	stackZoneSize := self computeStackZoneSize.
	"This slot holds the size of the native method zone in 1k units. (pad to word boundary)."
	hdrCogCodeSize := (self getShortFromFile: f swap: swapBytes) * 1024.
	cogCodeSize := desiredCogCodeSize ~= 0
						ifTrue: [desiredCogCodeSize]
						ifFalse:
							[hdrCogCodeSize = 0
									ifTrue: [self defaultCogCodeSize]
									ifFalse: [hdrCogCodeSize]].
	desiredCogCodeSize := hdrCogCodeSize.
	self assert: f position = 40.
	hdrEdenBytes	:= self getLongFromFile: f swap: swapBytes.
	objectMemory edenBytes: (desiredEdenBytes ~= 0
						ifTrue: [desiredEdenBytes]
						ifFalse:
							[hdrEdenBytes = 0
									ifTrue: [objectMemory defaultEdenBytes]
									ifFalse: [hdrEdenBytes]]).
	desiredEdenBytes := hdrEdenBytes.
	hdrMaxExtSemTabSize := self getShortFromFile: f swap: swapBytes.
	hdrMaxExtSemTabSize ~= 0 ifTrue:
		[self setMaxExtSemSizeTo: hdrMaxExtSemTabSize].
	"pad to word boundary.  This slot can be used for anything else that will fit in 16 bits.
	 Preserve it to be polite to other VMs."
	the2ndUnknownShort	:= self getShortFromFile: f swap: swapBytes.
	self assert: f position = 48.
	firstSegSize := self getLongFromFile: f swap: swapBytes.
	objectMemory firstSegmentSize: firstSegSize.
	"For Open PICs to be able to probe the method cache during
	 simulation the methodCache must be relocated to memory."
	methodCacheSize := methodCache size * BytesPerWord.
	primTraceLogSize := primTraceLog size * BytesPerWord.
	"allocate interpreter memory. This list is in address order, low to high.
	 In the actual VM the stack zone exists on the C stack."
	heapBase := (Cogit guardPageSize
				+ cogCodeSize
				+ stackZoneSize
				+ methodCacheSize
				+ primTraceLogSize
				+ self rumpCStackSize) roundUpTo: objectMemory allocationUnit.
	heapSize := dataSize
				+ extraBytes
				+ objectMemory newSpaceBytes
				+ self interpreterAllocationReserveBytes
				+ (objectMemory hasSpurMemoryManagerAPI
					ifTrue: [headerSize]
					ifFalse: [0]).
	heapBase := objectMemory
					setHeapBase: heapBase
					memoryLimit:  heapBase + heapSize
					endOfMemory: heapBase + dataSize.

	self assert: cogCodeSize \\ 4 = 0.
	self assert: objectMemory memoryLimit \\ 4 = 0.
	self assert: self rumpCStackSize \\ 4 = 0.
	"read in the image in bulk, then swap the bytes if necessary"
	f position: headerSize.
	objectMemory memory: ((cogit processor endianness == #little
					ifTrue: [LittleEndianBitmap]
					ifFalse: [Bitmap]) new: objectMemory memoryLimit // 4).
	count := objectMemory readHeapFromImageFile: f dataBytes: dataSize.
	count ~= dataSize ifTrue: [self halt].
	]
		ensure: [f close].
	self moveMethodCacheToMemoryAt: objectMemory cogCodeBase + cogCodeSize + stackZoneSize.
	self movePrimTraceLogToMemoryAt: objectMemory cogCodeBase + cogCodeSize + stackZoneSize + methodCacheSize.

	self ensureImageFormatIsUpToDate: swapBytes.

	bytesToShift := objectMemory memoryBaseForImageRead - oldBaseAddr.  "adjust pointers for zero base address"
	Utilities
		informUser: 'Relocating object pointers...'
		during: [self initializeInterpreter: bytesToShift].
	self initializeCodeGenerator