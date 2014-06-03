initialize-release
initialize
	<doNotGenerate>
	vmOwner := vmOwnerLock := numThreads := numThreadsIncrement := 0.
	memoryIsScarce := false.
	"N.B.  Do not initialize threadLocalStorage; leave this to ioInitThreadLocalThreadIndices"