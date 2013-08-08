initialization
openOn: fileName extraMemory: extraBytes
	"InterpreterSimulator new openOn: 'clone.im' extraMemory: 100000"

	| f version headerSize count heapSize oldBaseAddr bytesToShift swapBytes hdrNumStackPages
	 hdrEdenBytes hdrCogCodeSize stackZoneSize methodCacheSize headerFlags primTraceLogSize |
	"open image file and read the header"

	["begin ensure block..."
	f := FileStream readOnlyFileNamed: fileName.
	imageName := f fullName.
	f binary.
	version := self nextLongFrom: f.  "current version: 16r1968 (=6504) vive la revolucion!"
	(self readableFormat: version)
		ifTrue: [swapBytes := false]
		ifFalse: [(version := objectMemory byteSwapped: version) = self imageFormatVersion
					ifTrue: [swapBytes := true]
					ifFalse: [self error: 'incomaptible image format']].
	headerSize := self nextLongFrom: f swap: swapBytes.
	heapSize := self nextLongFrom: f swap: swapBytes.  "first unused location in heap"
	oldBaseAddr := self nextLongFrom: f swap: swapBytes.  "object memory base address of image"
	objectMemory specialObjectsOop: (self nextLongFrom: f swap: swapBytes).
	objectMemory lastHash: (self nextLongFrom: f swap: swapBytes).  "Should be loaded from, and saved to the image header"

	savedWindowSize	:= self nextLongFrom: f swap: swapBytes.
	headerFlags			:= self nextLongFrom: f swap: swapBytes.
	self setImageHeaderFlagsFrom: headerFlags.
	extraVMMemory		:= self nextLongFrom: f swap: swapBytes.
	hdrNumStackPages	:= self nextShortFrom: f swap: swapBytes.
	"4 stack pages is small.  Should be able to run with as few as
	 three. 4 should be comfortable but slow.  8 is a reasonable
	 default. Can be changed via vmParameterAt: 43 put: n"
	numStackPages := desiredNumStackPages ~= 0
						ifTrue: [desiredNumStackPages]
						ifFalse: [hdrNumStackPages = 0
									ifTrue: [self defaultNumStackPages]
									ifFalse: [hdrNumStackPages]].
	desiredNumStackPages := hdrNumStackPages.
	stackPages := self stackPagesClass new. "Temporary for computeStackZoneSize"
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
	hdrEdenBytes	:= self nextLongFrom: f swap: swapBytes.
	objectMemory edenBytes: (desiredEdenBytes ~= 0
						ifTrue: [desiredEdenBytes]
						ifFalse:
							[hdrEdenBytes = 0
									ifTrue: [objectMemory defaultEdenBytes]
									ifFalse: [hdrEdenBytes]]).
	desiredEdenBytes := hdrEdenBytes.
	"For Open PICs to be able to probe the method cache during
	 simulation the methodCache must be relocated to memory."
	methodCacheSize := methodCache size * BytesPerWord.
	primTraceLogSize := primTraceLog size * BytesPerWord.
	"allocate interpreter memory. This list is in address order, low to high.
	 In the actual VM the stack zone exists on the C stack."
	heapBase := cogCodeSize
				+ stackZoneSize
				+ methodCacheSize
				+ primTraceLogSize
				+ self rumpCStackSize.
	objectMemory setMemoryLimit:   heapBase
						+ heapSize
						+ objectMemory edenBytes
						+ self interpreterAllocationReserveBytes
						+ extraBytes.

	objectMemory initialize.
	self assert: cogCodeSize \\ 4 = 0.
	self assert: objectMemory memoryLimit \\ 4 = 0.
	self assert: self rumpCStackSize \\ 4 = 0.
	"read in the image in bulk, then swap the bytes if necessary"
	f position: headerSize.
	objectMemory memory: ((cogit processor endianness == #little
					ifTrue: [LittleEndianBitmap]
					ifFalse: [Bitmap]) new: objectMemory memoryLimit // 4).
	count := f readInto: objectMemory memory startingAt: heapBase // 4 + 1 count: heapSize // 4.
	count ~= (heapSize // 4) ifTrue: [self halt].
	]
		ensure: [f close].
	objectMemory setEndOfMemory: heapBase + heapSize.
	self moveMethodCacheToMemoryAt: cogCodeSize + stackZoneSize.
	self movePrimTraceLogToMemoryAt: cogCodeSize + stackZoneSize + methodCacheSize.

	self ensureImageFormatIsUpToDate: swapBytes.

	bytesToShift := objectMemory startOfMemory - oldBaseAddr.  "adjust pointers for zero base address"
	Utilities informUser: 'Relocating object pointers...'
				during: [self initializeInterpreter: bytesToShift].
	self initializeCodeGenerator