process primitive support
isBoundProcess: aProcess
	^self isBoundThreadId: (self ownerIndexOfProcess: aProcess)