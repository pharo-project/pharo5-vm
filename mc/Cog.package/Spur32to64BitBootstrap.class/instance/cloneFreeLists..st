bootstrap image
cloneFreeLists: obj32
	| obj64 |
	obj64 := heap64
				allocateSlots: heap64 numFreeLists
				format: heap64 wordIndexableFormat
				classIndex: heap64 wordSizeClassIndexPun.
	reverseMap at: obj64 put: obj32.
	^map at: obj32 put: obj64