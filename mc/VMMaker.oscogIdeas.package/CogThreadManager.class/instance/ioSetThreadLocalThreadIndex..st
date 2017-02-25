simulation
ioSetThreadLocalThreadIndex: index
	<doNotGenerate>
	"See platforms/<plat>/vm/sqPlatformSpecific.h for the real definition."
	threadLocalStorage ifNil:
		[threadLocalStorage := WeakIdentityKeyDictionary new].
	threadLocalStorage at: Processor activeProcess put: index