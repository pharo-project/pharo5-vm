initialization
openOn: fileName extraMemory: extraBytes
	"InterpreterSimulator new openOn: 'clone.im' extraMemory: 100000"

	| f version headerSize count oldBaseAddr bytesToShift swapBytes
	  hdrNumStackPages hdrEdenBytes headerFlags |
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
	objectMemory setEndOfMemory: (self nextLongFrom: f swap: swapBytes).  "first unused location in heap"
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
	"pad to word boundary.  This slot can be used for anything else that will fit in 16 bits.
	 Preserve it to be polite to images run on Cog."
	theUnknownShort	:= self getShortFromFile: f swap: swapBytes.
	hdrEdenBytes		:= self nextLongFrom: f swap: swapBytes.
	objectMemory edenBytes: (hdrEdenBytes = 0
							ifTrue: [objectMemory defaultEdenBytes]
							ifFalse: [hdrEdenBytes]).
	desiredEdenBytes := hdrEdenBytes.
	"allocate interpreter memory"
	objectMemory setMemoryLimit: objectMemory endOfMemory + extraBytes + objectMemory edenBytes + self interpreterAllocationReserveBytes.

	"read in the image in bulk, then swap the bytes if necessary"
	f position: headerSize.
	objectMemory memory: (Bitmap new: objectMemory memoryLimit // 4).
	count := f readInto: objectMemory memory startingAt: 1 count: objectMemory endOfMemory // 4.
	count ~= (objectMemory endOfMemory // 4) ifTrue: [self halt].
	]
		ensure: [f close].

	self ensureImageFormatIsUpToDate: swapBytes.

	objectMemory initialize.
	bytesToShift := objectMemory startOfMemory - oldBaseAddr.  "adjust pointers for zero base address"
	UIManager default informUser: 'Relocating object pointers...'
				during: [self initializeInterpreter: bytesToShift].
