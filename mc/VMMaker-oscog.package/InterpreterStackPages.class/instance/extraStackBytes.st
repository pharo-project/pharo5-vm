initialization
extraStackBytes
	"See initializeStack:numSlots:pageSize:stackLimitOffset:stackPageHeadroom:
	``Because stack pages grow down...''"
	^self cCode: 'BytesPerWord' inSmalltalk: [0]