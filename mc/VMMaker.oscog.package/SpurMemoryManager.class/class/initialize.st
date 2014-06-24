class initialization
initialize
	"SpurMemoryManager initialize"
	BitsPerByte := 8.

	"An obj stack is a stack of objects stored in a hidden root slot, such as
	 the markStack or the ephemeronQueue.  It is a linked list of segments,
	 with the hot end at the head of the list.  It is a word object.  The stack
	 pointer is in ObjStackTopx and 0 means empty.  The list goes through
	 ObjStackNextx. We don't want to shrink objStacks, since they're used
	 in GC and its good to keep their memory around.  So unused pages
	 created by popping emptying pages are kept on the ObjStackFreex list.
	 ObjStackNextx must be the last field for swizzleObjStackAt:."
	ObjStackPageSlots := 4092. "+ double header = 16k bytes per page in 32-bits"
	ObjStackTopx := 0.
	ObjStackMyx := 1.
	ObjStackFreex := 2.
	ObjStackNextx := 3.
	ObjStackFixedSlots := 4.
	ObjStackLimit := ObjStackPageSlots - ObjStackFixedSlots.
	"There are currently three obj stacks, the mark stack, the weaklings and the ephemeron queue."
	MarkStackRootIndex := self basicNew classTableRootSlots.
	WeaklingStackRootIndex := MarkStackRootIndex + 1.
	EphemeronQueueRootIndex := MarkStackRootIndex + 2.

	MarkObjectsForEnumerationPrimitives := false.

	"The remap buffer support is for compatibility; Spur doesn't GC during allocation.
	 Eventually this should die."
	RemapBufferSize := 25.

	"Extra roots are for plugin support."
	ExtraRootsSize := 2048 "max. # of external roots"