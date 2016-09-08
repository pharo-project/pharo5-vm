instantiation
maxSlotsForNewSpaceAlloc
	"Almost entirely arbitrary, but we dont want 1Mb bitmaps allocated in eden.
	 But this choice means no check for numSlots > maxSlotsForNewSpaceAlloc
	 for non-variable allocations."
	^self fixedFieldsOfClassFormatMask