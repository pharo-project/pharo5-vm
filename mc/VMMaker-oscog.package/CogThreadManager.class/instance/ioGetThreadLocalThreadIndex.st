simulation
ioGetThreadLocalThreadIndex
	<doNotGenerate>
	"Answer the thread index of the current thread/process or 0 if it is not yet defined.
	 See platforms/<plat>/vm/sqPlatformSpecific.h for the actual definition."
	^threadLocalStorage
		ifNil: [1] "pre initialization"
		ifNotNil: [threadLocalStorage at: Processor activeProcess]