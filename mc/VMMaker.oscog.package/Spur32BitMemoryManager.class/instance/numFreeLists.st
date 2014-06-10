free space
numFreeLists
	"Answer the number of free lists.  We use freeListsMask, a bitmap, to avoid
	 reading empty list heads.  This hsould fit in a machine word to end up in a
	 register during free chunk allocation."
	^32