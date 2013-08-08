image save/restore
readImageFromFile: f HeapSize: desiredHeapSize StartingAt: imageOffset
	"Read an image from the given file stream, allocating the given amount of memory to its object heap. Fail if the image has an unknown format or requires more than the given amount of memory."
	"Details: This method detects when the image was stored on a machine with the opposite byte ordering from this machine and swaps the bytes automatically. Furthermore, it allows the header information to start 512 bytes into the file, since some file transfer programs for the Macintosh apparently prepend a Mac-specific header of this size. Note that this same 512 bytes of prefix area could also be used to store an exec command on Unix systems, allowing one to launch Smalltalk by invoking the image name as a command."
	"This code is based on C code by Ian Piumarta and Smalltalk code by Tim Rowledge. Many thanks to both of you!!"

	| swapBytes headerStart headerSize dataSize oldBaseAddr
	  minimumMemory heapSize bytesRead bytesToShift
	  hdrNumStackPages hdrEdenBytes hdrCogCodeSize headerFlags hdrMaxExtSemTabSize |
	<var: #f type: 'sqImageFile '>
	<var: #memStart type: 'usqInt'>
	<var: #desiredHeapSize type: 'usqInt'>
	<var: #headerStart type: 'squeakFileOffsetType '>
	<var: #dataSize type: 'size_t '>
	<var: #imageOffset type: 'squeakFileOffsetType '>

	metaclassSizeBits := 6 * BytesPerWord.	"guess (Metaclass instSize * BPW)"
	swapBytes := self checkImageVersionFrom: f startingAt: imageOffset.
	headerStart := (self sqImageFilePosition: f) - BytesPerWord.  "record header start position"

	headerSize			:= self getLongFromFile: f swap: swapBytes.
	dataSize			:= self getLongFromFile: f swap: swapBytes.
	oldBaseAddr		:= self getLongFromFile: f swap: swapBytes.
	objectMemory specialObjectsOop: (self getLongFromFile: f swap: swapBytes).
	objectMemory lastHash: (self getLongFromFile: f swap: swapBytes). "N.B.  not used."
	savedWindowSize	:= self getLongFromFile: f swap: swapBytes.
	headerFlags			:= self getLongFromFile: f swap: swapBytes.
	self setImageHeaderFlagsFrom: headerFlags.
	extraVMMemory		:= self getLongFromFile: f swap: swapBytes. "N.B.  not used."
	hdrNumStackPages	:= self getShortFromFile: f swap: swapBytes.
	"4 stack pages is small.  Should be able to run with as few as
	 three. 4 should be comfortable but slow.  8 is a reasonable
	 default.  Can be changed via vmParameterAt: 43 put: n.
	 Can be set as a preference (Info.plist, VM.ini, command line etc).
	 If desiredNumStackPages is already non-zero then it has been
	 set as a preference.  Ignore (but preserve) the header's default."
	numStackPages := desiredNumStackPages ~= 0
						ifTrue: [desiredNumStackPages]
						ifFalse: [hdrNumStackPages = 0
									ifTrue: [self defaultNumStackPages]
									ifFalse: [hdrNumStackPages]].
	desiredNumStackPages := hdrNumStackPages.
	"This slot holds the size of the native method zone in 1k units. (pad to word boundary)."
	hdrCogCodeSize := (self getShortFromFile: f swap: swapBytes) * 1024.
	cogCodeSize := desiredCogCodeSize ~= 0
						ifTrue: [desiredCogCodeSize]
						ifFalse:
							[hdrCogCodeSize = 0
									ifTrue: [self defaultCogCodeSize]
									ifFalse: [hdrCogCodeSize]].
	hdrEdenBytes		:= self getLongFromFile: f swap: swapBytes.
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

	"compare memory requirements with availability"
	minimumMemory := cogCodeSize "no need to include the stackZone; this is alloca'ed"
						+ dataSize
						+ objectMemory edenBytes
						+ self interpreterAllocationReserveBytes.
	heapSize             :=  cogCodeSize "no need to include the stackZone; this is alloca'ed"
						+ desiredHeapSize
						"+ edenBytes" "don't include edenBytes; this is part of the heap and so part of desiredHeapSize"
						+ self interpreterAllocationReserveBytes.
	heapSize < minimumMemory ifTrue:
		[self insufficientMemorySpecifiedError].

	"allocate a contiguous block of memory for the Squeak heap and ancilliary data structures"
	"N.B. If the platform needs to it will redefine this macro to make heapSize
	 an in/out parameter and assign the ammount actually allocated into heapSize.
	 See e.g. platforms/Mac OS/vm/sqPlatformSpecific.h.  (I *hate* this. eem 7/23/2009)"
	"objectMemory memory: (self cCode: 'sqAllocateMemory(minimumMemory, heapSize)').  "
	objectMemory memory: (self
								allocateMemory: heapSize
								minimum: minimumMemory
								imageFile: f
								headerSize: headerSize) asUnsignedInteger.	
	
	objectMemory memory = nil ifTrue: [self insufficientMemoryAvailableError].
	heapBase := objectMemory memory + cogCodeSize.
	self assert: objectMemory startOfMemory = heapBase.
	objectMemory setMemoryLimit: objectMemory memory + heapSize - 24.  "decrease memoryLimit a tad for safety"
	objectMemory setEndOfMemory: heapBase + dataSize.

	"position file after the header"
	self sqImageFile: f Seek: headerStart + headerSize.

	"read in the image in bulk, then swap the bytes if necessary"
	bytesRead := self cCode: 'sqImageFileReadEntireImage(pointerForOop(heapBase), sizeof(unsigned char), dataSize, f)'.	
	bytesRead ~= dataSize ifTrue: [self unableToReadImageError].

	self ensureImageFormatIsUpToDate: swapBytes.

	"compute difference between old and new memory base addresses"
	bytesToShift := heapBase - oldBaseAddr.
	self initializeInterpreter: bytesToShift.  "adjusts all oops to new location"
	self initializeCodeGenerator.
	^dataSize