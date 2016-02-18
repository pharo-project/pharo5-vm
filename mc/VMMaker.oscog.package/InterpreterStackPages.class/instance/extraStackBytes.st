initialization
extraStackBytes
	"See initializeStack:numSlots:pageSize:stackLimitOffset:stackPageHeadroom:
	``Because stack pages grow down...''"
	^self cCode: [objectMemory wordSize] inSmalltalk: [0]