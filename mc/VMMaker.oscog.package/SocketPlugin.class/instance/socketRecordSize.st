primitives
socketRecordSize
	"Return the size of a Smalltalk socket record in bytes."

	^ self cCode: 'sizeof(SQSocket)' inSmalltalk: [12]