allocation
shorten: objOop toIndexableSize: indexableSize
	"Reduce the number of indexable fields in objOop, a pointer object, to nSlots. Convert the
	 unused residual to a free chunk. Without changes to numSlotsForShortening:toIndexableSize:
	 this only works for arrayFormat and longFormat objects.
	 Answer the number of bytes returned to free memory, which may be zero if no change was possible."
	self subclassResponsibility