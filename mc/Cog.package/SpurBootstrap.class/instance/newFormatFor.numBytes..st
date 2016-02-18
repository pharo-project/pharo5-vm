bootstrap image
newFormatFor: oldObj numBytes: numBytesIfBits
	"OLD:
	 0	no fields
	 1	fixed fields only (all containing pointers)
	 2	indexable fields only (all containing pointers)
	 3	both fixed and indexable fields (all containing pointers)
	 4	both fixed and indexable weak fields (all containing pointers).

	 5	unused
	 6	indexable word fields only (no pointers)
	 7	indexable long (64-bit) fields (only in 64-bit images)
 
	 8-11	indexable byte fields only (no pointers) (low 2 bits are low 2 bits of size)
	 12-15	compiled methods:
	 	    # of literal oops specified in method header,
	 	    followed by indexable bytes (same interpretation of low 2 bits as above)"

	"NEW:
	 0 = 0 sized objects (UndefinedObject True False et al)
	 1 = non-indexable objects with inst vars (Point et al)
	 2 = indexable objects with no inst vars (Array et al)
	 3 = indexable objects with inst vars (MethodContext AdditionalMethodState et al)
	 4 = weak indexable objects with inst vars (WeakArray et al)
	 5 = weak non-indexable objects with inst vars (ephemerons) (Ephemeron)
	 6 = reserved
	 7 = forwarder format (also immediate class format)
	 9          64-bit indexable
	 10 - 11 32-bit indexable
	 12 - 15 16-bit indexable
	 16 - 23 byte indexable
	 24 - 31 compiled method"
	| oldFormat |
	oldFormat := oldHeap formatOf: oldObj.
	oldFormat <= 4 ifTrue:
		[^oldFormat].
	oldFormat >= 12 ifTrue: "CompiledMethod"
		[^24 + (self wordSize - numBytesIfBits bitAnd: self wordSizeMask)].
	oldFormat >= 8 ifTrue: "ByteArray et al"
		[^16 + (self wordSize - numBytesIfBits bitAnd: self wordSizeMask)].
	oldFormat = 6 ifTrue: "32-bit indexable"
		[^10 + (numBytesIfBits bitAnd: self wordSizeMask) sign].
	oldFormat = 7 ifTrue: "64-bit indexable"
		[^9].
	self error: 'illegal old format'