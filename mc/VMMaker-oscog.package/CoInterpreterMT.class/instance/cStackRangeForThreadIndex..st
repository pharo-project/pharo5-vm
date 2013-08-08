simulation
cStackRangeForThreadIndex: threadIndex
	"Each simulated processor thread gets 4k of the rump C stack.
	 The top-most section is reserved for in-memory variables such as vmOwnerLock."
	<doNotGenerate>
	| top |
	^(threadIndex between: 1 and: cogThreadManager maxNumThreads) ifTrue:
		[top := self rumpCStackAddress - (threadIndex * RumpCStackSize).
		 top - RumpCStackSize + 1 to: top]