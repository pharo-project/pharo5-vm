initialization
initializeSchedulerIndices
	super initializeSchedulerIndices.
	"Class Process"
	ThreadIdIndex := 4.

	"disown result/own argument flags & max number of threads"
	LockGUIThreadShift := 16.
	LockGUIThreadFlag := 1 << LockGUIThreadShift.
	OwnVMForeignThreadFlag := 1 << (LockGUIThreadShift + 1).
	VMAlreadyOwnedHenceDoNotDisown := 1 << (LockGUIThreadShift + 2).
	ProcessUnaffinedOnDisown := 1 << (LockGUIThreadShift + 3).
	DisownFlagsShift := LockGUIThreadShift + 4.
	ThreadIdMask := (1 << LockGUIThreadShift) - 1 "results in 64k thread indices"
