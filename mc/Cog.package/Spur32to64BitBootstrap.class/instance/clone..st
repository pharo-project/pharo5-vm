bootstrap image
clone: obj32
	| obj64 format numSlots numBytes hash |
	format := heap32 formatOf: obj32.
	numSlots := heap32 numSlotsOf: obj32.
	format > heap32 lastPointerFormat ifTrue:
		[format < heap32 firstByteFormat
			ifTrue:
				[format = heap32 firstLongFormat
					ifTrue:
						[numSlots := heap32 numSlotsOf: obj32.
						 numSlots odd ifTrue:
							[format := format + 1].
						 numSlots := numSlots + 1 // 2]
					ifFalse: [self error: 'bad format']]
			ifFalse:
				[numBytes := heap32 numBytesOf: obj32.
				 format < heap32 firstCompiledMethodFormat
					ifTrue:
						[format := heap64 byteFormatForNumBytes: numBytes.
						 numSlots := numSlots + 1 // 2]
					ifFalse:
						[numSlots := heap32 numPointerSlotsOf: obj32.
						 numBytes := numBytes - (numSlots * heap32 bytesPerOop).
						 format := (heap64 byteFormatForNumBytes: numBytes) + heap32 firstCompiledMethodFormat - heap32 firstByteFormat.
						 numSlots := numSlots + (heap64 numSlotsForBytes: numBytes)]]].
	obj64 := heap64
				allocateSlots: numSlots
				format: format
				classIndex: (heap32 classIndexOf: obj32).
	(hash := heap32 rawHashBitsOf: obj32) ~= 0 ifTrue:
		[heap64 setHashBitsOf: obj64 to: hash].
	(heap32 isImmutable: obj32) ifTrue:
		[heap64 setIsImmutableOf: obj64 to: true].
	(heap32 isPinned: obj32) ifTrue:
		[heap64 setIsPinnedOf: obj64 to: true].
	self deny: (heap32 isRemembered: obj32).
	self deny: (heap32 isMarked: obj32).
	self deny: (heap32 isGrey: obj32).
	reverseMap at: obj64 put: obj32.
	^map at: obj32 put: obj64