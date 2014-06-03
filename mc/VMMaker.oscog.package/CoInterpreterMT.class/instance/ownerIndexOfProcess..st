process primitive support
ownerIndexOfProcess: aProcess
	^self ownerIndexOfThreadId: (self threadIdFieldOf: aProcess)