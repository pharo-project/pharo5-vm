private - conversion
sizeOfInt
	"Size in bytes of an integer, for this C compiler on this machine."

	^ self cCode: 'sizeof(int)' inSmalltalk: [4]
