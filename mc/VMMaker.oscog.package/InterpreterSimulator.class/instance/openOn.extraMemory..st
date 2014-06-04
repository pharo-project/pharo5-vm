initialization
openOn: fileName extraMemory: extraBytes
	"InterpreterSimulator new openOn: 'clone.im' extraMemory: 100000"

	| f version headerSize count oldBaseAddr bytesToShift swapBytes |
	"open image file and read the header"

	["begin ensure block..."
	f := FileStream readOnlyFileNamed: fileName.
	imageName := f fullName.
	f binary.
	version := self nextLongFrom: f.  "current version: 16r1968 (=6504) vive la revolucion!"
	(self readableFormat: version)
		ifTrue: [swapBytes := false]
		ifFalse: [(version := self byteSwapped: version) = self imageFormatVersion
					ifTrue: [swapBytes := true]
					ifFalse: [self error: 'incomaptible image format']].
	headerSize := self nextLongFrom: f swap: swapBytes.
	self setEndOfMemory: (self nextLongFrom: f swap: swapBytes).  "first unused location in heap"
	oldBaseAddr := self nextLongFrom: f swap: swapBytes.  "object memory base address of image"
	specialObjectsOop := self nextLongFrom: f swap: swapBytes.
	lastHash := self nextLongFrom: f swap: swapBytes.  "Should be loaded from, and saved to the image header"
	lastHash = 0 ifTrue: [lastHash := 999].

	savedWindowSize	:= self nextLongFrom: f swap: swapBytes.
	fullScreenFlag		:= self nextLongFrom: f swap: swapBytes.
	extraVMMemory		:= self nextLongFrom: f swap: swapBytes.

	"allocate interpreter memory"
	self setMemoryLimit: endOfMemory + extraBytes.

	"read in the image in bulk, then swap the bytes if necessary"
	f position: headerSize.
	memory := Bitmap new: memoryLimit // 4.
	count := f readInto: memory startingAt: 1 count: endOfMemory // 4.
	count ~= (endOfMemory // 4) ifTrue: [self halt].
	]
		ensure: [f close].

	swapBytes ifTrue: [Utilities informUser: 'Swapping bytes of foreign image...'
								during: [self reverseBytesInImage]].

	self initialize.
	bytesToShift := self startOfMemory - oldBaseAddr.  "adjust pointers for zero base address"
	Utilities informUser: 'Relocating object pointers...'
				during: [self initializeInterpreter: bytesToShift].
