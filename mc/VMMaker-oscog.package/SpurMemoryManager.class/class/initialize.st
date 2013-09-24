class initialization
initialize
	"CogObjectMemory initialize"
	NumFreeLists := 65. "One for each size up to and including 64 slots. One for sizes > 64 slots."
	CheckObjectOverwrite := true.

	"The remap buffer support is for compatibility; Spur doesn't GC during allocation.
	 Eventually this should die."
	RemapBufferSize := 25