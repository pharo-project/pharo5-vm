private - SQSocket access
socketRecordSize
	"Answer the size of a SQSocket data structure in bytes."

	^ self cCode: 'sizeof(SQSocket)' inSmalltalk: [Smalltalk wordSize * 3]
