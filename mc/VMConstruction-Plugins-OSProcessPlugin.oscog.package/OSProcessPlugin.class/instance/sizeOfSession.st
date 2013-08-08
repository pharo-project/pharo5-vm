private - conversion
sizeOfSession
	"Size of a SESSIONIDENTIFIERTYPE. Should match usage in the SQFile data structure,
	otherwise we should get compiler warnings."

	^ self cCode: 'sizeof(SESSIONIDENTIFIERTYPE)' inSmalltalk: [4]
