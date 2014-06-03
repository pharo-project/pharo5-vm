process primitive support
isAffinedProcess: aProcess
	^self isAffinedThreadId: (self ownerIndexOfProcess: aProcess)