image save/restore
readImageFromFile: f HeapSize: desiredHeapSize StartingAt: imageOffset
	"Read an image from the given file stream, allocating an amount of memory to its object heap.
	
	 V3: desiredHeapSize is the total size of the heap.  Fail if the image has an unknown format or
	 requires more than the specified amount of memory.

	 Spur: desiredHeapSize is ignored; this routine will attempt to provide at least extraVMMemory's
	 ammount of free space after the image is loaded, taking any free space in teh image into account.
	 extraVMMemory is stored in the image header and is accessible as vmParameterAt: 23.  If
	 extraVMMemory is 0, the value defaults to the default grow headroom.  Fail if the image has an
	 unknown format or if sufficient memory cannot be allocated.

	 Details: This method detects when the image was stored on a machine with the opposite byte
	 ordering from this machine and swaps the bytes automatically. Furthermore, it allows the header
	 information to start 512 bytes into the file, since some file transfer programs for the Macintosh
	 apparently prepend a Mac-specific header of this size. Note that this same 512 bytes of prefix
	 area could also be used to store an exec command on Unix systems, allowing one to launch
	 Smalltalk by invoking the image name as a command."

	| headerStart headerSize headerFlags dataSize oldBaseAddr swapBytes
	  minimumMemory bytesRead bytesToShift heapSize firstSegSize
	  hdrEdenBytes hdrMaxExtSemTabSize hdrNumStackPages allocationReserve |
	<var: #f type: #sqImageFile>
	<var: #heapSize type: #usqInt>
	<var: #dataSize type: #'size_t'>
	<var: #minimumMemory type: #usqInt>
	<var: #desiredHeapSize type: #usqInt>
	<var: #allocationReserve type: #usqInt>
	<var: #headerStart type: #squeakFileOffsetType>
	<var: #imageOffset type: #squeakFileOffsetType>

	metaclassNumSlots := 6.	"guess Metaclass instSize"
	classNameIndex := 6.		"guess (Class instVarIndexFor: 'name' ifAbsent: []) - 1"
	swapBytes := self checkImageVersionFrom: f startingAt: imageOffset.
	headerStart := (self sqImageFilePosition: f) - 4.  "record header start position"

	headerSize			:= self getWord32FromFile: f swap: swapBytes.
	dataSize			:= self getLongFromFile: f swap: swapBytes.
	oldBaseAddr		:= self getLongFromFile: f swap: swapBytes.
	objectMemory specialObjectsOop: (self getLongFromFile: f swap: swapBytes).
	objectMemory lastHash: (self getLongFromFile: f swap: swapBytes). "N.B.  not used."
	savedWindowSize	:= self getLongFromFile: f swap: swapBytes.
	headerFlags		:= self getLongFromFile: f swap: swapBytes.
	self setImageHeaderFlagsFrom: headerFlags.
	extraVMMemory	:= self getWord32FromFile: f swap: swapBytes.
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
	"pad to word boundary.  This slot can be used for anything else that will fit in 16 bits.
	 It is used for the cog code size in Cog.  Preserve it to be polite to other VMs."
	theUnknownShort	:= self getShortFromFile: f swap: swapBytes.
	hdrEdenBytes		:= self getWord32FromFile: f swap: swapBytes.
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
	firstSegSize := self getLongFromFile: f swap: swapBytes.
	objectMemory firstSegmentSize: firstSegSize.
	"compare memory requirements with availability"
	allocationReserve := self interpreterAllocationReserveBytes.
	minimumMemory := dataSize
						+ objectMemory newSpaceBytes
						+ allocationReserve.
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
			[heapSize :=  desiredHeapSize
						+ objectMemory newSpaceBytes
						+ (desiredHeapSize - dataSize > allocationReserve
							ifTrue: [0]
							ifFalse: [allocationReserve]).
			 heapSize < minimumMemory ifTrue:
				[self insufficientMemorySpecifiedError]].

	"allocate a contiguous block of memory for the Squeak heap"
	objectMemory memory: (self
								allocateMemory: heapSize
								minimum: minimumMemory
								imageFile: f
								headerSize: headerSize) asUnsignedInteger.
	objectMemory memory ifNil: [self insufficientMemoryAvailableError].

	objectMemory
		setHeapBase: objectMemory memory
		memoryLimit: objectMemory memory + heapSize
		endOfMemory: objectMemory memory + dataSize.

	"position file after the header"
	self sqImageFile: f Seek: headerStart + headerSize.

	"read in the image in bulk, then swap the bytes if necessary"
	bytesRead := objectMemory readHeapFromImageFile: f dataBytes: dataSize.
	bytesRead ~= dataSize ifTrue: [self unableToReadImageError].

	self ensureImageFormatIsUpToDate: swapBytes.

	"compute difference between old and new memory base addresses"
	bytesToShift := objectMemory memoryBaseForImageRead - oldBaseAddr.
	self initializeInterpreter: bytesToShift.  "adjusts all oops to new location"
	^dataSize